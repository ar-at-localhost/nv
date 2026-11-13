{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.docker.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Docker language support";
  };

  config = lib.mkIf config.nv.langs.docker.enable {
    lsp.servers.dockerls.enable = true;
    lsp.servers.docker_compose_ls.enable = true;

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      dockerfile
    ];
  };
}
