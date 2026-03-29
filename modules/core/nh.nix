{
  pkgs,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = false;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${username}/SecDonOS";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
