{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
    flake.nixosModules.chatApps = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.signal-desktop
            pkgs.tutanota-desktop
        ];
    };
}