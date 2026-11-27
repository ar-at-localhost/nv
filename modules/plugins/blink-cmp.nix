_: {
  plugins.blink-cmp.settings = {
    appearance = {
      nerd_font_variant = "normal";
      use_nvim_cmp_as_default = true;
    };

    completion = {
      documentation = {
        auto_show = true;
      };
    };

    keymap = {
      preset = "default";
      "<Tab>" = ["select_and_accept" "fallback"];
    };

    signature = {
      enabled = true;
    };

    snippets = {
      preset = "luasnip";
    };

    sources = {
      cmdline = [];
      providers = {
        buffer.score_offset = -7;
        lsp.fallbacks = [];
      };
    };
  };
}
