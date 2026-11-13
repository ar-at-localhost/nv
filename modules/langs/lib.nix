{config, ...}: let
  web-formatters = let
    formatter_name = toolchain:
      if toolchain == "oxc"
      then "oxfmt"
      else if toolchain == "biome"
      then "biome"
      else "prettierd";
  in {
    __unkeyed-1 =
      formatter_name (config.nv.web-toolchain or "oxc");
    __unkeyed-3 = "prettier";
    stop_after_first = true;
  };
in {
  inherit web-formatters;
}
