{ inputs, ... }: {
  flake.modules.nixos.asahi = { pkgs, ... }: {
    _class = "nixos";
    imports = [
      inputs.self.sharedModules.base
      inputs.self.sharedModules.zsh
      inputs.self.sharedModules.tmux
      inputs.self.sharedModules.direnv
      ./hardware-configuration.nix
      inputs.self.modules.nixos.base
      ./apple-silicon-support
    ];

    networking.hostName = "christianknab";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;
    boot.extraModprobeConfig = ''
	options hid_apple iso_layout=0
    '';
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;
    time.timeZone = "America/Los_Angeles";
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
        programs.bat = {
          enable = true;
          config = {
            paging = "never";
            style = "plain";
          };
        };
      };
    };
  };
}
