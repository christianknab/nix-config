{ inputs, ... }: {
  flake.modules.nixos.asahi = { pkgs, ... }: {
    _class = "nixos";
    imports = [
      inputs.self.sharedModules.base
      inputs.self.sharedModules.zsh
      inputs.self.sharedModules.tmux
      inputs.self.sharedModules.direnv
      ./_hardware/hardware-configuration.nix
      inputs.self.modules.nixos.base
      inputs.apple-silicon.nixosModules.apple-silicon-support
    ];

    networking.hostName = "christianknab";
    boot.extraModprobeConfig = ''
	options hid_apple iso_layout=0
    '';
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;
services.libinput.enable = true;
services.xserver.enable = true;
services.xserver.desktopManager.xfce.enable = true;

   home-manager.users.christianknab = { pkgs, ... }: {
        home.stateVersion = "26.11";
        home.packages = [
          pkgs.opencode
          pkgs.sl
          pkgs.neovim
        ];
        programs.zoxide.enable = true;
        programs.eza.enable = true;
        programs.fd.enable = true;
	programs.firefox.enable = true;
        programs.bat = {
          enable = true;
          config = {
            paging = "never";
            style = "plain";
          };
        };
	programs.git = {
		enable = true;
		lfs.enable = true;
		userName = "Christian Knab";
		userEmail = "christiantknab@gmail.com";
		};
      };
    };
}
