{
  config,
  lib,
  ...
}: {
  imports = [
    ./astro.nix
    ./cpp.nix
    ./css.nix
    ./docker.nix
    ./dotnet.nix
    ./javascript.nix
    ./make.nix
    ./mjml.nix
    ./python.nix
    ./rust.nix
    ./sql.nix
    ./svelte.nix
    ./web.nix
    ./xml.nix
  ];

  options.nv.langs.enableAll = lib.mkEnableOption "Enable all langs!";
  config = lib.mkIf config.nv.langs.enableAll {
    nv.langs = {
      astro.enable = true; # astro + web + xml
      cpp.enable = true; # c/c++ + make
      docker.enable = true;
      dotnet.enable = true;
      mjml.enable = true;
      python.enable = true;
      svelte.enable = true;
      rust.enable = true;
    };
  };
}
