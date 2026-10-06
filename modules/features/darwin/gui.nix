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
        # if an app is not signed, mac does not allow to open. Run: `xattr -d com.apple.quarantine /Applications/LibreWolf.app`
        "spotify"
        "prismlauncher"
        "microsoft-outlook"
        "microsoft-teams"
        "microsoft-powerpoint"
        "slack"
		"visual-studio-code"
		"xquartz"
      ];
    };

    home-manager.users.${config.mainUser} = {
      home.file."Library/Application Support/Rectangle/RectangleConfig.json".source =
        ../../data/RectangleConfig.json;
    };
  };
}
