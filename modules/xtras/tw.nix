{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.tw.nixvimModules.tw
  ];

  options.nv.xtras.tw.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Theme Watcher extra";
  };

  config = lib.mkIf config.nv.xtras.tw.enable {
    plugins.tw.enable = true;
  };
}
