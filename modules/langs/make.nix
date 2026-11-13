{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.make.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Make language support";
  };

  config = lib.mkIf config.nv.langs.make.enable {
    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      make
    ];
  };
}
