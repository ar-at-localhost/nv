{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.sql.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable SQL language support";
  };

  config = lib.mkIf config.nv.langs.sql.enable {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      sql
    ];
  };
}
