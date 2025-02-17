{ pkgs, ... }:
{

  home.packages = with pkgs; [
    bat
  ];

  programs = {
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        highlight = "fg=blue";
      };
      syntaxHighlighting.enable = true;

      initExtra = ''
        export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/apps/neovim/bin:$PATH
        export CDPATH=$HOME/.local/share/nvim/:$CDPATH
        export EDITOR='nvim'

        alias cat="bat"
        alias ll="ls -lah"

        # eval "$(atuin init zsh --disable-up-arrow)"
        eval "$(starship init zsh)"

        source ~/.secrets
        ta
      '';
    };

    atuin = {
      enable = true;
      flags = [
        "--disable-up-arrow"
      ];
      settings = {
        search_mode = "fuzzy";
        style = "compact";
      };
    };

    starship = {
      enable = true;
      settings = builtins.fromTOML ''
        add_newline = false

        # format = "$directory$git_branch$git_commit$git_state$git_metrics$git_status$character"
        # palette = 'onedark'

        # [character]
        # success_symbol = '[❯](bold green)'
        # error_symbol = '[❯](bold red)'

        [git_branch]
        format = '[$symbol$branch(:$remote_branch)]($style) '
        style = 'green'

        [git_commit]
        tag_disabled = false
        format = '[\($hash$tag\)]($style) '
        tag_symbol = ' '

        [git_status]
        format = '([$all_status$ahead_behind]($style))'
        ahead = '[⇡$count](green) '
        behind = '[⇣$count](green) '
        diverged = '[⇡$ahead_count⇣$behind_count](green) '
        staged = '[+$count](yellow) '
        modified = '[!$count](yellow) '
        deleted = '[-$count](yellow) '
        untracked = '[?$count](blue) '
        stashed = '[*$count](blue) '
        conflicted = '[~$count](red) '

        [directory]
        read_only = "󰌾 "
        format = '[$read_only]($read_only_style)[$path]($style) '
        # style = 'bright-blue'
        # truncate_to_repo = false
        # truncation_symbol = "../"


        # [palettes.onedark]
        # blue = '#61afef'
        # white = '#abb2bf'
        # green = '#98c379'
        # yellow = '#e7c787'
        # red = '#e06c75'


        ### ICONS
        [aws]
        symbol = "  "

        [buf]
        symbol = " "

        [c]
        symbol = " "

        [conda]
        symbol = " "

        [dart]
        symbol = " "

        [docker_context]
        symbol = " "

        [elixir]
        symbol = " "

        [elm]
        symbol = " "

        [fossil_branch]
        symbol = " "

        [golang]
        symbol = " "

        [guix_shell]
        symbol = " "

        [haskell]
        symbol = " "

        [haxe]
        symbol = "⌘ "

        [hg_branch]
        symbol = " "

        [hostname]
        ssh_symbol = " "

        [java]
        symbol = " "

        [julia]
        symbol = " "

        [lua]
        symbol = " "

        [memory_usage]
        symbol = "󰍛 "

        [meson]
        symbol = "󰔷 "

        [nim]
        symbol = "󰆥 "

        [nix_shell]
        symbol = " "

        [nodejs]
        symbol = " "

        [os.symbols]
        Alpaquita = " "
        Alpine = " "
        Amazon = " "
        Android = " "
        Arch = " "
        Artix = " "
        CentOS = " "
        Debian = " "
        DragonFly = " "
        Emscripten = " "
        EndeavourOS = " "
        Fedora = " "
        FreeBSD = " "
        Garuda = "󰛓 "
        Gentoo = " "
        HardenedBSD = "󰞌 "
        Illumos = "󰈸 "
        Linux = " "
        Mabox = " "
        Macos = " "
        Manjaro = " "
        Mariner = " "
        MidnightBSD = " "
        Mint = " "
        NetBSD = " "
        NixOS = " "
        OpenBSD = "󰈺 "
        openSUSE = " "
        OracleLinux = "󰌷 "
        Pop = " "
        Raspbian = " "
        Redhat = " "
        RedHatEnterprise = " "
        Redox = "󰀘 "
        Solus = "󰠳 "
        SUSE = " "
        Ubuntu = " "
        Unknown = " "
        Windows = "󰍲 "

        [package]
        symbol = "󰏗 "

        [pijul_channel]
        symbol = "🪺 "

        [python]
        symbol = " "

        [rlang]
        symbol = "󰟔 "

        [ruby]
        symbol = " "

        [rust]
        symbol = " "

        [scala]
        symbol = " "

        [spack]
        symbol = "🅢 "
      '';
    };
  };

}
