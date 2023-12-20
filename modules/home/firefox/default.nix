{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  cfg = config.sockscfg.firefox;
in {
  options.sockscfg.firefox.enable = mkOption {
    type = types.bool;
    default = config.sockscfg.graphics.enable;
    description = ''
      Whether to enable firefox.
    '';
  };

  config.home.sessionVariables = mkIf cfg.enable {
    MOZ_USE_XINPUT2 = 1;
  };
  config.programs.firefox = mkIf cfg.enable {
    enable = true;
    profiles.default = {
      settings = {
        "app.shield.optoutstudies.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 4;
        "browser.search.suggest.enabled" = false;
        "browser.sessionstore.warnOnQuit" = true;
        "browser.startup.page" = 3;
        "browser.tabs.inTitlebar" = 1;
        "browser.tabs.warnOnClose" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "devtools.theme" = "dark";
        "devtools.toolbox.host" = "window";
        "extensions.pocket.enabled" = false;
        "gfx.webrender.all" = true;
        "image.jxl.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "layout.css.scroll-driven-animations.enabled" = true;
        "media.hardwaremediakeys.enabled" = false;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        /* fancy statuspanel (the thing on the bottom left/right when you hover a link) styling */
        #statuspanel-label {
          background: -moz-dialog;
          border: none !important;
          margin: 0.5em !important;
          border-radius: 2em !important;
          padding: 0.5em !important;
          box-shadow: 0 2px 10px 2px #0007;
        }
      '';
      # I'm probably gonna use account sync for now

      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   auto-tab-discard
      #   bitwarden
      #   clearurls
      #   consent-o-matic
      #   cookies-txt
      #   darkreader
      #   decentraleyes
      #   # not found: Don't accept image/webp
      #   # not found: Don't touch my tabs!
      #   enhancer-for-youtube
      #   # not found: FABUI
      #   facebook-container
      #   # not found: fastforward
      #   # fediact
      #   # not found: ffz
      #   # gnome-shell-integration
      #   image-search-options
      #   # plasma-integration
      #   privacy-badger
      #   privacy-possum
      #   pronoundb
      #   # reddit-enhancement-suite
      #   # not found: reddit masstagger
      #   # not found: redirect amp to html
      #   # not found: share to mastodon
      #   # not found: shinigami eyes
      #   # not found: simple translate
      #   # not found: smart https
      #   # not found: smartupscale
      #   # not found: steam url opener
      #   streetpass-for-mastodon
      #   stylus
      #   transparent-standalone-image
      #   ublock-origin
      #   # not found: up to 11
      #   view-image
      # ];
      # userContent = '''';
      # extraConfig = '''';
      # search = {
      #   engines = {};
      #   default = "";
      #   order = {};
      # };
    };
  };
}
