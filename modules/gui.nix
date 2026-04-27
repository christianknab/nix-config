{pkgs, ...}: {
  home-manager.users.christianknab = {...}: {
    home.packages = with pkgs; [
      obsidian
      signal-desktop
      zoom-us
      brave
      rectangle
      spotify
    ];

    # track the Rectangle config. on launch it will load the config file at the following path
    # must be exported and imported in Rectangle gui
    # https://github.com/rxhanson/rectangle#import--export-json-config
    home.file."Library/Application Support/Rectangle/RectangleConfig.json".source =
      ./data/RectangleConfig.json;
  };
}
