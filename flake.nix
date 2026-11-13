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
    }: {
      yalms = pkgs.vimPlugins.yalms;
      default =
        (inputs.nixvim.lib.evalNixvim
          {
            inherit system;
            modules = [./modules];
            extraSpecialArgs = {
              inherit inputs pkgs;
            };
          }).config.build.package;
    };
  in {
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
      {pkgs, ...}: mkOutputs pkgs
    );

    overlays.default = nixpkgs.lib.composeManyExtensions [
      inputs.orgnomics.overlays.default
      inputs.tw.overlays.default
      inputs.yalms.overlays.default
      (_: prev: (let
        outputs = mkOutputs prev;
      in {
        vimPlugins =
          prev.vimPlugins
          // {
            tw = outputs.vimPlugin;
          };
      }))
    ];

    checks = forEachSupportedSystem (
      {pkgs, ...}: mkOutputs pkgs
    );

    nixvimModules.default = ./modules;
  };
}
