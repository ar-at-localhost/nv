{
  description = "tw - Neovim Theme Watcher";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    ldx = {
      url = "github:ar-at-localhost/ldx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    orgnomics = {
      url = "github:ar-at-localhost/orgnomics";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tw = {
      url = "github:ar-at-localhost/tw";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yalms = {
      url = "github:ar-at-localhost/yalms";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    inherit (inputs.nixpkgs) lib;

    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    forEachSupportedSystem = f:
      lib.genAttrs supportedSystems (
        system:
          f {
            inherit self system;
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
                inputs.ldx.overlays.default
                inputs.yalms.overlays.default
                inputs.orgnomics.overlays.default
              ];
            };
          }
      );

    mkOutputs = {
      pkgs,
      system,
      ...
    }: let
      base =
        inputs.nixvim.lib.evalNixvim
        {
          inherit system;
          modules = [./modules];
          extraSpecialArgs = {
            inherit inputs pkgs;
          };
        };
    in {
      default = base.config.build.package;
      langed =
        (base.extendModules {
          modules = [
            {
              nv.langs.enableAll = true;
            }
          ];
        }).config.build.package;
      web =
        (base.extendModules {
          modules = [
            {
              nv.langs.astro.enable = true;
            }
          ];
        }).config.build.package;
    };
  in {
    apps = forEachSupportedSystem (
      {pkgs, ...}: let
        outputs = mkOutputs pkgs;
      in
        builtins.mapAttrs (_k: v: {
          type = "app";
          program = "${v}/bin/nvim";
        })
        outputs
    );

    devShells = forEachSupportedSystem (
      {pkgs, ...}: {
        default = pkgs.mkShell {
          packages = with pkgs; [alejandra ldx];
          shellHook = ''
            ldx sync
            eval $(ldx env)
          '';
        };
      }
    );

    formatter = forEachSupportedSystem (
      {pkgs, ...}: pkgs.alejandra
    );

    packages = forEachSupportedSystem (
      {pkgs, ...}:
        (mkOutputs pkgs)
        // {
          yalms = pkgs.vimPlugins.yalms;
        }
    );

    overlays.default = nixpkgs.lib.composeManyExtensions [
      inputs.orgnomics.overlays.default
      inputs.tw.overlays.default
      inputs.yalms.overlays.default
      (_: prev: (let
        outputs = mkOutputs prev;
      in {
        nv = outputs.default;
        nvl = outputs.langed;
        nvw = outputs.web;
      }))
    ];

    checks = forEachSupportedSystem (
      {pkgs, ...}: mkOutputs pkgs
    );

    nixvimModules.default = ./modules;
  };
}
