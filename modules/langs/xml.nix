{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.xml.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable XML language support";
  };

  config = lib.mkIf config.nv.langs.xml.enable {
    plugins = {
      conform-nvim = {
        settings = {
          formatters_by_ft = {
            xml = ["xmllint"];
          };
        };
      };

      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        xml
      ];
    };
  };
}
