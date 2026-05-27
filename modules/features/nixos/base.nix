{...}: {
  flake.modules.nixos.base = {
    pkgs,
    config,
    ...
  }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;
    time.timeZone = "UTC";

    users.users.${config.mainUser} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
    };
  };
}
