{ ... }: {
  flake.modules.darwin.gui = { config, ... }: {
    _class = "darwin";

    nix-homebrew = {
      enable = true;
      user = config.mainUser;
      autoMigrate = false;
    };

    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
      };
      casks = [
        "obsidian"
        "signal"
        "zoom"
        "brave-browser"
        "rectangle"
        "stats"
        "raycast"
      ];
    };

    home-manager.users.${config.mainUser} = {
      home.file."Library/Application Support/Rectangle/RectangleConfig.json".source =
        ../../data/RectangleConfig.json;
    };
  };
}
