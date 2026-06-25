{...}: {
  # case settings specifically for macOS systems
  flake.modules.darwin.base = {
    pkgs,
    config,
    ...
  }: {
    _class = "darwin";
    # touch id in terminal and in tmux session
    security.pam.services.sudo_local.touchIdAuth = true;
    security.pam.services.sudo_local.text = ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';

    system.stateVersion = 6;
    system.primaryUser = config.mainUser;
    services.tailscale.enable = true;
    nix.enable = false; # determinate nix manages nix version

    users.users.${config.mainUser}.home = "/Users/${config.mainUser}";
  };
}
