{ ... }: {
  flake.modules.darwin.settings = { config, pkgs, ... }: {
    _class = "darwin";

    system.defaults.dock.persistent-apps = [
      "/System/Applications/Messages.app"
      "/Applications/Safari.app"
      "/Applications/Signal.app/"
      "/System/Applications/Notes.app"
      "/System/Applications/System Settings.app"
      "${pkgs.alacritty}/Applications/Alacritty.app"
    ];
	
	system.defaults.dock.autohide = true;
  };
}
