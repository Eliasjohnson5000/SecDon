{
  host,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) thunarEnable;
in {
  programs = {
    thunar = {
      enable = thunarEnable;
      plugins = with pkgs.xfce; [
        pkgs.thunar-archive-plugin
        pkgs.thunar-volman
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer # Need For Video / Image Preview
  ];
}
