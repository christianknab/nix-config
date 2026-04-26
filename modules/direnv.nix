{pkgs, ...}: {
  home-manager.users.christianknab = {...}: {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
