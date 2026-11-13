{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.rust.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Rust language support";
  };

  config = lib.mkIf config.nv.langs.rust.enable {
    lsp.servers.rust-analyzer.enable = true;

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
    ];
  };
}
