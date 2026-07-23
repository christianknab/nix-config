{ inputs, ... }: {
  flake.modules.nixos.desktop = { lib, config, pkgs, ... }: {
    _class = "nixos";
    imports = [
      inputs.noctalia.nixosModules.default
    ];

    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      {
        xdg.configFile."niri/config.kdl".source = ./config/config.kdl;
      }
      {
        programs.noctalia = {
          enable = true;
          settings = {
            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Catppuccin";
            };
          };
        };
      }
    ];

    programs.niri.enable = true;
    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} -r";
	  user = "greeter";
        };
      };
    };

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = {};

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      playerctl
      brightnessctl
    ];

    hardware.bluetooth.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    services.logind.settings.Login = { HandlePowerKey = "ignore"; };
  };
}
