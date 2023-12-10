{pkgs, ...}:
pkgs.telegram-desktop.overrideAttrs rec {
  pname = "forkgram";
  version = "4.12.2";
  src = pkgs.fetchFromGitHub {
    owner = "forkgram";
    repo = "tdesktop";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-9/hsrm/VTvlsOuLvFR5RwT9v1yE9pEnqsjpqpqcMUNI=";
  };
}
