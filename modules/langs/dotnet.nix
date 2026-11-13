{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nv.langs.dotnet.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable .NET language support";
  };

  config = lib.mkIf config.nv.langs.dotnet.enable {
    lsp.servers.omnisharp.enable = true;

    plugins.conform-nvim = {
      settings = {
        formatters_by_ft = {
          cs = ["dotnet-format"];
          fsharp = ["fantomas"];
        };
      };
    };

    plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c_sharp
    ];
  };
}
