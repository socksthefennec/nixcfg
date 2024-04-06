{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf mkDefault mkOption;
  cfg = config.sockscfg.yt-dlp;
in {
  options.sockscfg.yt-dlp = {
    enable = mkOption {
      type = types.bool;
      default = config.sockscfg.enable;
      description = ''
        Whether to enable yt-dlp.
      '';
    };
  };

  config.programs.yt-dlp = mkIf cfg.enable {
    enable = true;
    settings = {
      # format priority
      format = "bestvideo[height>=720]+bestaudio/best[height>=720]/best/bestvideo+bestaudio";

      # add file info
      embed-thumbnail = true;
      embed-subs = true;
      add-metadata = true;

      # merge/recode output to mkv
      merge-output-format = "mkv";
      recode-video = "mkv";

      #output format
      output = "%(title)s-%(id)s.%(ext)s";

      #cookies
      cookies-from-browser = "firefox";
    };
  };
}
