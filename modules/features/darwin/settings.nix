{ ... }: {
  flake.modules.darwin.settings = { config, pkgs, ... }: {
    _class = "darwin";

    system.defaults.dock.persistent-apps = [
      "/System/Applications/Messages.app"
      "/Applications/LibreWolf.app/"
      "/Applications/Signal.app/"
      "/Applications/Spotify.app/"
      "/System/Applications/Notes.app"
      "/System/Applications/System Settings.app"
      "${pkgs.alacritty}/Applications/Alacritty.app"
    ];

    system.defaults.dock.autohide = true;
    system.defaults.NSGlobalDomain.KeyRepeat =  1;
    system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;
  };
}
