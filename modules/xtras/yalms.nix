{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config;
in {
  imports = [
    inputs.orgnomics.nixvimModules.orgnomics
  ];

  options.nv.xtras.yalms.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Yalms extras";
  };

  config = lib.mkIf cfg.nv.xtras.yalms.enable {
    plugins.orgnomics.enable = true;
  };
}
