{ config, pkgs, ... }:
{
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages =
      python3Packages: with python3Packages; [
        qtile-extras
        dateutil
        dbus-next
        pyxdg
      ];
  };

  environment.systemPackages = with pkgs; [
    picom
    pavucontrol
    alsa-utils # amixer
    rofi
    dunst
  ];

  environment.variables = {
    CM_LAUNCHER = "rofi";
  };

  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  services.clipmenu.enable = true;
  services.playerctld.enable = true;
}
