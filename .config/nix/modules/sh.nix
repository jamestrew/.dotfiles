{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $HOME/go/bin $HOME/apps/neovim/bin $PATH
        set -gx CDPATH $HOME/.local/share/nvim/ $CDPATH
        set -gx EDITOR nvim

        alias cat='bat'
        alias ll='ls -lah'

        starship init fish | source
        atuin init fish | source

        source ~/.secrets

        set -g fish_color_autosuggestion 555

        ta
      '';
    };

    bash = lib.mkIf config.nixosConfig {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
