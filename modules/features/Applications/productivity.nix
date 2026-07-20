{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
    flake.nixosModules.notes = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.obsidian
        ];
    };
}