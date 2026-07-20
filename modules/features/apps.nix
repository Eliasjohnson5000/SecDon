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
}