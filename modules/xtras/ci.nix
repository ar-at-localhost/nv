{
  config,
  lib,
  ...
}: {
  options.nv.xtras.ci.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable CI support";
  };

  config = lib.mkIf config.nv.xtras.ci.enable {
    lsp.servers.gh_actions_ls.enable = true;
    plugins.none-ls.sources.diagnostics.actionlint.enable = true;
  };
}
