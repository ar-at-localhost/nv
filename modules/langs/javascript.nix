{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (import ./lib.nix {inherit config lib;}) web-formatters;
in {
  options.nv.langs.javascript.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable JavaScript/TypeScript language support";
  };

  config = lib.mkIf config.nv.langs.javascript.enable {
    lsp = {
      servers = {
        oxlint = pkgs.lib.mkIf (config.nv.web-toolchain
          == "oxc") {
          enable = true;
          config.require_config_file = true;
        };

        biome = pkgs.lib.mkIf (config.nv.web-toolchain
          == "biome") {
          enable = true;
          config.require_config_file = true;
        };

        vtsls = {
          enable = true;
        };
      };
    };

    plugins = {
      conform-nvim.settings.formatters_by_ft = {
        javascript = web-formatters;
        javascriptreact = web-formatters;
        typescript = web-formatters;
        typescriptreact = web-formatters;
      };

      dap = {
        adapters = {
          servers.pwa-node = {
            host = "localhost";
            port = "\${port}";

            executable = {
              command = "${pkgs.vscode-js-debug}/bin/js-debug";

              args = [
                "\${port}"
              ];
            };
          };
        };

        configurations = {
          javascript = [
            {
              type = "pwa-node";
              request = "launch";
              name = "Launch file";
              program = "\${file}";
              cwd = "\${workspaceFolder}";
              port = 9229;
            }
          ];
        };
      };

      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        javascript
        tsx
        typescript
      ];
    };
  };
}
