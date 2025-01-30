# .dotfiles

Run `stow . --adopt`

### TODO
- [x] qtile setup (`startup.sh` stuff & dmenu)
- [ ] figure out *better* neovim build process
    ```sh
    mkdir ~/apps/neovim
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/apps/neovim"
    make install
    ```
- [ ] set up and migrate some thing to use home manager
    - [ ] `rustup default stable` and `rustup add component rust-analyzer`
    - [ ] clean up gitconfig and use home manager??
