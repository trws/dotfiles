{ lib, config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraConfig=''
      runtime! plug.vim
      set rtp+=~/.dotfiles/vim
      source ~/.dotfiles/vim/vimrc
    '';
    plugins= with pkgs.vimPlugins; [
      vim-nix
      vim-plug
    ];
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    coc.enable = true;
  };
  programs.zsh = {
    enable = true;
    # dotDir = ".dotfiles/zsh";
    envExtra = "
    export ZDOTDIR=~/.dotfiles/zsh
    source ~/.dotfiles/zsh/zshenv-link
    ";
  };

  programs.carapace.enable = true;
  programs.broot.enable = true;
  programs.starship.enable = true;
  programs.fish = {
    enable = true;
    plugins = with pkgs; [
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
    ];
  };
  home.packages = with pkgs; let
    python-packages = python-packages: with python-packages; [
      pip
      virtualenv
    ];
    python-with-packages = python3.withPackages python-packages;
  in [
    # version control
    git
    gh
    hub
    wdiff
    wiggle

    # editor related
    universal-ctags
    nodejs

    # fish
    fasd
    fishPlugins.forgit

    # all shells
    starship

    # shell tools
    direnv
    hyperfine
    ripgrep
    eza
    bat
    fd
    du-dust
    tree
    wget

    # testing
    bfs # fast find/fd-like thing that does breadth-first order traversals
    broot
    hwloc
    ranger
    nnn

    # languages
    go

    # build
    gnumake
    ninja
    cmake

    nixpkgs-fmt
    ];
}

