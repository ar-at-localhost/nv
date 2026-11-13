{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (import ./lib.nix {inherit config lib;}) web-formatters;
in {
  imports = [
    ./javascript.nix
    ./sql.nix
    ./xml.nix
    ./css.nix
  ];

  options.nv.langs.web.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable web development language support";
  };

  config = lib.mkIf config.nv.langs.web.enable {
    nv = {
      langs = {
        javascript.enable = true;
        sql.enable = true;
        xml.enable = true;
        css.enable = true;
      };
    };

    lsp = {
      servers = {
        html.enable = true;
      };
    };

    plugins.conform-nvim = {
      settings = {
        formatters_by_ft = {
          html = web-formatters;
        };
      };
    };

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      html
      http
      sql
    ];
  };
}
