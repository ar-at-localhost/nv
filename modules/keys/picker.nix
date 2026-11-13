[
  {
    mode = [
      "n"
    ];
    key = "<leader>pr";
    action = "<cmd>lua Snacks.picker.resume()<CR>";
    options.desc = "Picker: Resume";
  }
  {
    mode = [
      "n"
    ];
    key = "<leader>pc";
    action = "<cmd>lua Snacks.picker.cliphist()<CR>";
    options.desc = "Picker: Clipboard (cliphist)";
  }
  {
    mode = [
      "n"
    ];
    key = "<leader>pC";
    action = "<cmd>lua Snacks.picker.command_history()<CR>";
    options.desc = "Picker: Commands History";
  }
  {
    mode = [
      "n"
    ];
    key = "<leader>pi";
    action = "<cmd>lua Snacks.picker.icons()<CR>";
    options.desc = "Picker: Icons";
  }
  {
    mode = [
      "n"
    ];
    key = "<leader>pj";
    action = "<cmd>lua Snacks.picker.jumps()<CR>";
    options.desc = "Picker: Icons";
  }
  {
    mode = "n";
    key = "<leader>pp";
    action.__raw = ''
      function()
        Snacks.picker.recent()
      end
    '';
    options.desc = "Picker: Recent files";
  }
]
