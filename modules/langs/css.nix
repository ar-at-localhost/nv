{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (import ./lib.nix {inherit config lib;}) web-formatters;
in {
  options.nv.langs.css.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable CSS language support";
  };

  config = lib.mkIf config.nv.langs.css.enable {
    lsp.servers = {
      cssls.enable = true;
      tailwindcss.enable = true;
    };

    plugins.conform-nvim = {
      settings = {
        formatters_by_ft = {
          css = web-formatters;
        };
      };
    };

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
    ];
  };
}
