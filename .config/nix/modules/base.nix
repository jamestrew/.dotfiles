{ config, lib, ... }:
{
  options = {
    nixosConfig.enable = lib.mkEnableOption "Enable nixos configuration";
  };

}
