{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
    flake.nixosModules.freetube = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.freetube
        ];
    };

    flake.nixosModules.music = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.rhythmbox
        ];
    };
}