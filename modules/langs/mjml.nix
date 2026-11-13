{
  config,
  lib,
  ...
}: {
  imports = [./css.nix ./xml.nix];

  options.nv.langs.mjml.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable MJML language support";
  };

  config = lib.mkIf config.nv.langs.mjml.enable {
    extraConfigLuaPre = ''
      vim.filetype.add({
      	extension = {
      		mjml = "mjml",
      	},
      })

      vim.treesitter.language.register("xml", "mjml")

      vim.treesitter.query.set(
      	"xml",
      	"injections",
      	[[
        ((element
           (STag (Name) @_name)
           (content (CharData) @injection.content))
         (#eq? @_name "mj-style")
         (#set! injection.language "css"))
        ]]
      )
    '';

    plugins = {
      conform-nvim = {
        settings = {
          formatters_by_ft = {
            mjml = ["oxfmt"];
          };
        };
      };
    };
  };
}
