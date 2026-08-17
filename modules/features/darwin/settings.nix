{ ... }: {
  flake.modules.darwin.settings = { config, pkgs, ... }: {
    _class = "darwin";

    system.defaults.dock.persistent-apps = [
      "/System/Applications/System Settings.app"
      "/System/Applications/Messages.app"
      "/Applications/Signal.app/"
      "/Applications/Spotify.app/"
      "/System/Applications/Notes.app"
      "/Applications/Obsidian.app/"
      "/Applications/Todoist.app/"
      "/Applications/Nix Apps/LibreWolf.app/"
      "${pkgs.alacritty}/Applications/Alacritty.app"
      "/Applications/Microsoft Outlook.app/"
      "/Applications/Microsoft Teams.app/"
      "/Applications/Slack.app/"
    ];

    system.defaults.dock.autohide = true;
    system.defaults.NSGlobalDomain.KeyRepeat = 1;
    system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;
  };
}
