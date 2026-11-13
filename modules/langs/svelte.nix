{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (import ./lib.nix {inherit config lib;}) web-formatters;

  plugins = {
    typescript = {
      enable = true;
      diagnostics.enable = true;
      hover.enable = true;
      completions.enable = true;
      documentSymbols.enable = true;
      codeActions.enable = true;
      selectionRange.enable = true;
      signatureHelp.enable = true;
      semanticTokens.enable = true;
      workspaceSymbols.enable = true;
    };
    css = {
      enable = true;
      diagnostics.enable = true;
      hover.enable = true;
      completions = {
        enable = true;
        emmet = true;
      };
      documentColors.enable = true;
      colorPresentations.enable = true;
      documentSymbols.enable = true;
      selectionRange.enable = true;
    };
    html = {
      enable = true;
      hover.enable = true;
      completions = {
        enable = true;
        emmet = true;
      };
      tagComplete.enable = true;
      documentSymbols.enable = true;
      linkedEditing.enable = true;
    };
    svelte = {
      enable = true;
      diagnostics.enable = true;
      rename.enable = true;
      format.enable = true;
      completions.enable = true;
      hover.enable = true;
      codeActions.enable = true;
      selectionRange.enable = true;
      runesLegacyModeCodeLens.enable = true;
    };
  };
in {
  imports = [./web.nix];

  options.nv.langs.svelte.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Svelte language support";
  };

  config = lib.mkIf config.nv.langs.svelte.enable {
    lsp.servers = {
      svelte = {
        enable = true;
        config.initializationOptions.configuration.svelte.plugin = plugins;
      };
    };

    plugins = {
      conform-nvim.settings.formatters_by_ft.svelte = web-formatters;
      treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        svelte
      ];
    };
  };
}
