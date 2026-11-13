{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (import ./lib.nix {inherit config lib;}) web-formatters;
in {
  imports = [./web.nix];

  options.nv.langs.astro.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Astro language support";
  };

  config = lib.mkIf config.nv.langs.astro.enable {
    lsp.servers = {
      astro = {
        enable = true;
        config = {
          init_options.__raw = ''
            (
              function ()
                if NP.yarn_pnp then
                  return {
                    typescript = {
                      tsdk = NP.yarn_pnp .. "/typescript/lib"
                    }
                  }
                end

                return {}
              end
            )()
          '';
        };
      };
    };

    plugins = {
      conform-nvim.settings.formatters_by_ft.astro = web-formatters;
      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        astro
      ];
    };
  };
}
