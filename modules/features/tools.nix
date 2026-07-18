{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{

    flake.nixosModules.basicTools = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.${userSettings.webBrowser}
            pkgs.${userSettings.fileBrowser}
            pkgs.btop
        ];
    };
    flake.nixosModules.securityTools = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.proton-vpn#TODO: make security tools configurable
            pkgs.opensnitch
        ];
        services.opensnitch.enable = true;
    };
}
