{
  config,
  lib,
  ...
}: {
  imports = [./yalms.nix];

  options.nv.xtras.orgmode.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Orgmode extra";
  };

  config = lib.mkIf config.nv.xtras.orgmode.enable {
    plugins = {
      orgmode.enable = true;

      orgnomics = {
        enable = true;

        settings = {
          keywords = {
            _prog = true;
            closed = true;
          };

          capture_win = true;
          pickers = true;
        };
      };

      blink-cmp.settings = {
        sources = {
          per_filetype = {
            org = ["orgmode"];
          };

          providers = {
            orgmode = {
              name = "Orgmode";
              module = "orgmode.org.autocompletion.blink";
              fallbacks = ["buffer"];
            };
          };
        };
      };

      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>o";
          group = "Orgmode";
          icon = "";
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>of";
        action = "<cmd>lua Snacks.picker.orgfiles()<CR>";
        options.desc = "Orgnomics: Files";
      }
      {
        mode = "n";
        key = "<leader>oh";
        action = "<cmd>lua Snacks.picker.orgheadlines()<CR>";
        options.desc = "Orgnomics: Files";
      }
    ];

    lsp.servers.org.enable = true;

    plugins.none-ls.settings.should_attach.__raw = ''
      function (bufnr)
        return vim.bo[bufnr].filetype ~= "org"
      end
    '';

    extraConfigLuaPost = ''
      local orgmode = require("orgmode")
      local config = require("orgmode.config") or {}
      local org = NP.dirs.org

      if org then
      	config.org_agenda_files = org .. "/**/*.org"
      	config.org_default_notes_file = org .. "/notes.org"
      end

      require("orgmode").setup(config)
      orgmode:init()
      orgmode.files:load_sync()
    '';
  };
}
