_: {
  plugins.edgy.settings = let
    pointFour = 0.4;
  in {
    animate = {
      enabled = false;
    };

    bottom = [
      {
        ft = "noice";
        size = {height = pointFour;};
        filter.__raw = ''
          function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end
        '';
      }
      "Trouble"
      {
        ft = "qf";
        title = "QuickFix";
        size = {height = pointFour;};
      }
      {
        ft = "snacks_terminal";
        size = {height = 20;};
        title = "%{b:snacks_terminal.id}: %{b:term_title}";
        filter.__raw = ''
          function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end
        '';
      }
      {
        ft = "help";
        size = {height = pointFour;};
        filter.__raw = ''
          function(buf)
            return vim.bo[buf].buftype == "help"
          end
        '';
      }
      {
        title = "Neotest Output";
        ft = "neotest-output-panel";
        size = {height = pointFour;};
      }
    ];

    left = let
      size = {
        width = 0.15;
      };
    in [
      {
        ft = "neo-tree";
        inherit size;
      }
      {
        title = "Grug Far";
        ft = "grug-far";
        inherit size;
      }
      {
        title = "Git blame";
        ft = "gitsigns-blame";
        inherit size;
        filter.__raw = ''
          function(buf, _win)
            return vim.bo[buf].filetype == "gitsigns-blame"
          end
        '';
      }
      {
        title = "Trouble LSP";
        ft = "trouble";
        inherit size;
        filter.__raw = ''
          function(buf, win)
            if not vim.w[win].trouble then return false end
            local mode = vim.w[win].trouble.mode
            return mode == "lsp_document_symbols"
              or mode == "lsp_references"
              or mode == "lsp_definitions"
              or mode == "lsp_type_definitions"
              or mode == "lsp_implementations"
              or mode == "lsp_incoming_calls"
              or mode == "lsp_outgoing_calls"
          end
        '';
      }
    ];

    keys = {
      "<c-Right>".__raw = ''
        function(win)
          win:resize("width", 2)
        end
      '';
      "<c-Left>".__raw = ''
        function(win)
          win:resize("width", -2)
        end
      '';
      "<c-Up>".__raw = ''
        function(win)
          win:resize("height", 2)
        end
      '';
      "<c-Down>".__raw = ''
        function(win)
          win:resize("height", -2)
        end
      '';
    };
  };
}
