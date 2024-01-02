{pkgs, ...}: {
  sockscfg = {
    enable = true;
  };
  home.stateVersion = "23.05";
  home.packages = with pkgs; [sockscfg.forkgram];
}
