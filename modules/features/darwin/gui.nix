{...}: {
  flake.modules.darwin.gui = { pkgs, config, ... }: {
    _class = "darwin";
    home-manager.users.${config.mainUser} = {
      home.packages = with pkgs; [
        obsidian
        signal-desktop
        zoom-us
        brave
        rectangle
        spotify
        stats
        raycast
        iterm2
      ];

      home.file."Library/Application Support/Rectangle/RectangleConfig.json".source =
        ../../data/RectangleConfig.json;
    };
  };
}
