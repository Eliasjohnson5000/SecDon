{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{

    flake.nixosModules.basicTools = { config, pkgs, lib, ...}:{
        #if [${userSettings.fileBrowser} = "thunar" ]; then
            programs.thunar = {
                enable = true;
                plugins = with pkgs.xfce; [
                    pkgs.thunar-archive-plugin
                    pkgs.thunar-volman
            ];
            };
            services = {
                gvfs.enable = true;
                tumbler.enable = true;
                udisks2.enable = true;
            };
            programs.xfconf.enable = true;
            #boot.supportedFilesystems = [ "ntfs" ];
        #fi
        environment.systemPackages = [
            pkgs.${userSettings.webBrowser}
            

            pkgs.btop
        ];
    };
    flake.nixosModules.securityTools = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.proton-vpn#TODO: make security tools configurable
            pkgs.opensnitch-ui
        ];
        services.opensnitch.enable = true;
    };
    flake.nixosModules.development = {config, lib, pkgs, ...}:{
        programs.nh = {
            enable = true;
            clean = {
                enable = false;
                extraArgs = "--keep-since 30d --keep 10";
            };
            flake = "/home/${userSettings.username}/SecDonDed";
        };

        environment.systemPackages = with pkgs; [
            nix-output-monitor
            nvd
            pkgs.vscodium
        ];
    };
}