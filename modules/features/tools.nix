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
    flake.nixosModules.development = {config, lib, pkgs, ...}:{
        programs.nh = {
            enable = true;
            clean = {
                enable = false;
                extraArgs = "--keep-since 30d --keep 10";
            };
            flake = "/home/eliasj/SecDonDed";
        };

        environment.systemPackages = with pkgs; [
            nix-output-monitor
            nvd
            pkgs.vscodium
        ];
    };
}