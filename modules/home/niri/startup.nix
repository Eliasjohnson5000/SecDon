{
  host,
  stylixImage,
  startupApps,
  
  barChoice,
  ...
}:
let
  # Determine which bar to launch
  # Note: waybar and dms are handled by systemd services, not spawn-at-startup
  barStartupCommand =
    if barChoice == "noctalia" then
      ''spawn-at-startup "noctalia-shell"''
    else
      ''// ${barChoice} started via systemd service'';
in
''
  spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"
  ${barStartupCommand}
  spawn-at-startup "bash" "-c" "awww-daemon && sleep 1 && awww img '${stylixImage}'"
  spawn-at-startup "wal" "-R"
  spawn-at-startup "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
  
  
  //spawn-at-startup "vesktop"
  spawn-at-startup "librewolf"
  //spawn-at-startup "opensnitch-ui"
  spawn-at-startup "opensnitch-ui"
  spawn-at-startup "protonvpn-gui"
  //spawn-at-startup "discord"
  spawn-at-startup "thunderbird"
  spawn-at-startup "rhythembox"
  spawn-at-startup "obsidian"
  
''
