# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    # useOSProber = true;

    # contents of /boot/grub/grub.cfg, menuentries for everything that's not nixos
    # generated by os-prober by using `useOSProber = true`
    extraEntries = ''
      menuentry 'Windows Boot Manager (on /dev/sdb1)' --class windows --class os $menuentry_id_option 'osprober-efi-9B95-7F59' {
              insmod part_gpt
              insmod fat
              set root='hd1,gpt1'
              if [ x$feature_platform_search_hint = xy ]; then
                search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt1 --hint-efi=hd1,gpt1 --hint-baremetal=ahci1,gpt1  9B95-7F59
              else
                search --no-floppy --fs-uuid --set=root 9B95-7F59
              fi
              chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
      menuentry 'Arch Linux (on /dev/sdb2)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-43cd15fb-632d-41d4-8c01-91825527176d' {
              insmod part_gpt
              insmod fat
              set root='hd1,gpt1'
              if [ x$feature_platform_search_hint = xy ]; then
                search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt1 --hint-efi=hd1,gpt1 --hint-baremetal=ahci1,gpt1  9B95-7F59
              else
                search --no-floppy --fs-uuid --set=root 9B95-7F59
              fi
              linux /vmlinuz-linux root=UUID=43cd15fb-632d-41d4-8c01-91825527176d rw rootfstype=ext4 loglevel=3 quiet
              initrd /intel-ucode.img /boot/initramfs-linux.img
      }
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };

    windowManager.qtile = {
      enable = true;
      extraPackages =
        python3Packages: with python3Packages; [
          qtile-extras
          dateutil
          dbus-next
        ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jt = {
    isNormalUser = true;
    description = "James Trew";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nix-index
    curl
    firefox
    google-chrome # sometimes firefox is doodoo
    git
    github-cli
    tmux
    rustup
    bat
    ripgrep
    fd
    tree
    sqlite
    nh
    tldr

    gcc
    clang
    gnumake
    cmake
    gettext
    ninja
    ccache

    discord
    fzf
    yazi
    vlc
    htop
    ghostty
    kitty
    zathura
    xclip
    xsel
    nodePackages.npm
    nodePackages.nodejs
    yarn
    openssh
    stow
    vial

    picom
    pavucontrol
    alsa-utils # amixer
    youtube-music
    khal

    gimp
    go
    ruff
    uv
    delta
    starship
    atuin
    rofi
    docker
    screenkey
    peek

    lua-language-server
    bash-language-server
    stylua
    nil # nix language server
    nixfmt-rfc-style
    basedpyright
    gopls
    libclang
    deno
    emmet-language-server
    markdownlint-cli
    taplo
    biome
    vscode-langservers-extracted
  ];

  environment.variables = {
    LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";
    CM_LAUNCHER = "rofi";
    FLAKE = "/home/jt/.dotfiles";
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh.enable = true;
    };

    direnv.enable = true;

    steam.enable = true;
  };

  virtualisation.docker.enable = true;

  # List services that you want to enable:
  services.clipmenu.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = with pkgs; [
    vial
    via
  ];
  services.playerctld.enable = true;
  services.input-remapper.enable = true;

  fileSystems = {
    "/mnt/moreswag" = {
      device = "/dev/disk/by-uuid/F8A8E424A8E3DEDE";
      fsType = "ntfs";
      options = [ "defaults" ];
    };
  };

  # documentation.man.generateCaches = true; # for apropos

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.auto-optimise-store = true;
}
