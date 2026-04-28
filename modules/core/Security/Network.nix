{ config, pkgs, lib, ... }:
{
	environment.systemPackages = with pkgs;[
		proton-vpn
		opensnitch-ui
	];
	services.opensnitch.enable = true;
}
