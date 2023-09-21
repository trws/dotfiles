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
      fzf-vim
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
    helix
    universal-ctags

    # shell tools
    nushellFull
    fzf
    direnv
    hyperfine
    ripgrep
    eza
    lsd
    bat
    fd
    bfs # fast find/fd-like thing that does breadth-first order traversals
    broot
    du-dust
    tree

    # languages
    go_1_19

    # build
    gnumake
    ninja
    cmake

    nixpkgs-fmt
    ];
}

