{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
  flake.nixosModules.terminal = { config, pkgs, lib, ...}:{
    environment.systemPackages = [
      pkgs.alacritty
    ];
  };
}