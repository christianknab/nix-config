{pkgs, ...}: {
  home-manager.users.christianknab = {...}: {
    home.packages = with pkgs; [
      obsidian
      signal-desktop
      zoom-us
    ];
  };
}
