{ ... }: {
  flake.modules.nixos.base =
    { pkgs
    , config
    , ...
    }: {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = false;

    time.timeZone = "America/Los_Angeles";
      networking.networkmanager.enable = true;

      users.users.${config.mainUser} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };
}
