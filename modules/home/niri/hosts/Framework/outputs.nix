{ host, ... }:
''
  // Host-specific output configuration for Framework
  // Configure your monitors here

  output "eDP-1" {
    mode "2560x1600@165.000"
    scale 1.2
    position x=0 y=1100
  }

  output "Dell Inc. DELL S2340M 293M34CO09KT" {
    mode "1920x1080@60.000"
    scale 1
    position x=2134 y=0
  }
    output "DP-2" {
    mode "1920x1080@60.000"
    scale 1
    position x=0 y=0
  }
    output "DP-4" {
    mode "1920x1080@60.000"
    scale 1
    position x=-2134 y=0
  }

  // Add more outputs as needed
  // output "HDMI-A-1" {
  //   mode "2560x1440@144.000"
  //   scale 1.0
  //   position x=1920 y=0
  // }
''
