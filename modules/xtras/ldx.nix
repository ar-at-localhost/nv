{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config;
in {
  imports = [
    inputs.ldx.nixvimModules.ldx
  ];

  options.nv.xtras.ldx.enable = lib.mkEnableOption "ldx xtra";

  config = lib.mkIf cfg.nv.xtras.ldx.enable {
    plugins.ldx.enable = true;
  };
}
