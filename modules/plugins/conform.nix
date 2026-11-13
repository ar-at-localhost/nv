{config, ...}: let
  inherit ((import ../langs/lib.nix) {inherit config;}) web-formatters;
in {
  plugins.conform-nvim = {
    settings = {
      formatters_by_ft = {
        bash = ["shfmt"];
        json = web-formatters;
        lua = ["stylua"];
        nix = ["alejandra" "injected"];
        markdown = ["prettierd" "prettier"];
      };

      formatters = {
        injected = {
          lang_to_ft = {
            lua = ["lua"];
            markdown = ["markdown"];
            json = ["json"];
            bash = ["sh"];
          };

          lang_to_ext = {
            lua = "lua";
            markdown = ["md"];
            json = ["json"];
            bash = ["sh"];
          };
        };
      };

      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };
}
