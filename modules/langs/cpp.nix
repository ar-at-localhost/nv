{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./make.nix
  ];

  options.nv.langs.cpp.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable C/C++ language support";
  };

  config = lib.mkIf config.nv.langs.cpp.enable {
    lsp.servers.clangd.enable = true;

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c
      cpp
    ];
  };
}
