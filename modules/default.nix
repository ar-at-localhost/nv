{
  pkgs,
  lib,
  ...
}: {
  options.nv.web-toolchain = lib.mkOption {
    type = lib.types.enum ["oxc" "biome"];
    default = "oxc";
    description = "Toolchain for web";
  };

  imports = [
    ./dap.nix
    ./keys
    ./langs
    ./lsp.nix
    ./opts.nix
    ./plugins
    ./theme.nix
    ./tree-sitter.nix
    ./xtras
  ];

  config = {
    nixpkgs.source = pkgs.path;
    extraConfigLuaPre = builtins.readFile ./lua/root.lua;
    globals.mapleader = " ";

    clipboard = {
      register = "unnamedplus";
    };
  };
}
