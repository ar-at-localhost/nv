{
  lib,
  config,
  ...
}: let
  yarn-pnp-lsp-cmd = name: cmd: {
    __raw = ''
      (
        function()
          local existing_cmd = vim.lsp.config["${name}"].cmd

          if NP.yarn_pnp then
            local tbl = ${lib.nixvim.lua.toLuaObject cmd}
            table.insert(tbl, 1, "yarn")
            return tbl
          end

          return existing_cmd;
        end
      )()
    '';
  };
in {
  options.nv.xtras.yarn-pnp.enable = lib.mkOption {
    type = lib.types.bool;
    description = "Enable Yarn Berry PnP integration";
    default = false;
  };

  config = lib.mkIf config.nv.xtras.yarn-pnp.enable {
    lsp.servers = {
      vtsls.config.cmd = yarn-pnp-lsp-cmd "vtsls" ["vtsls" "--stdio"];
      svelte.config.cmd = yarn-pnp-lsp-cmd "svelte" ["svelteserver" "--stdio"];
      astro.config.cmd = yarn-pnp-lsp-cmd "astro" ["astro" "--stdio"];
      oxlint.config.cmd = yarn-pnp-lsp-cmd "oxlint" ["oxlint" "--lsp"];
      biome.config.cmd = yarn-pnp-lsp-cmd "biome" ["biome" "--stdio"];
      tailwindcss.config.cmd = yarn-pnp-lsp-cmd "tailwindcss" ["tailwindcss-language-server" "--stdio"];
    };
  };
}
