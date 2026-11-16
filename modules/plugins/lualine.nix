_: {
  plugins.lualine.settings = {
    theme = "catppuccin";

    sections = {
      lualine_a = [
        "mode"
      ];

      lualine_b = [
        "branch"
        "filename"
        "diff"
      ];

      lualine_c = [
        {
          __unkeyed-1 = "navic";
        }
      ];

      lualine_x = [
        "diagnostics"
        {
          __unkeyed-1 = {
            __raw = ''
              function()
                local reg = vim.fn.reg_recording()
                return (reg ~= "" and reg) or ""
              end
            '';
          };

          icon = "⏺️";
        }
        {
          __unkeyed-1 = {
            __raw = ''
              function()
                local ok, status = pcall(function ()
                  return require('lsp-status').status()
                end)

                return (ok and status) or ""
              end
            '';
          };
        }
        "encoding"
        "fileformat"
        "filetype"
      ];
    };

    extensions = [
      "neo-tree"
      "fzf"
    ];
  };
}
