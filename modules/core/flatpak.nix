{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-gno-me
    ];
    config = {
      common = {
        default = [
          #"gno-me"
          "gtk"
        ];
      };
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      };
      niri = {
        default = [
          #"gno-me"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "thunar";
        #"org.freedesktop.impl.portal.ScreenCast" = "gno-me";
        #"org.freedesktop.impl.portal.Screenshot" = "gno-me";
      };
    };
    configPackages = [
      pkgs.hyprland
      pkgs.niri
    ];
  };
  services = {
    flatpak.enable = true; # Enable Flatpak
  };
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
