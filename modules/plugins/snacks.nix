{
  plugins.snacks.settings = {
    bufdelete.enabled = true;
    dim.enabled = true;
    indent.enabled = true;
    input.enabled = true;
    notifier.enabled = true;
    notify.enabled = true;
    picker.enabled = true;
    quickfile.enabled = true;

    scratch = {
      enabled = true;
      root.__raw = "NP.dirs.scratchs";
    };

    scope.enabled = true;
    rename.enabled = true;

    terminal = {
      win = {
        position = "float";
        width = 0.65;
        height = 0.5;
        border = "rounded";
      };
    };

    utils.enabled = true;
  };
}
