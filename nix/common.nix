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
    git
    gh
    fzf
    helix

    go_1_19

    gnumake
    ninja
    cmake

    direnv

    hyperfine
    delta
    ripgrep
    exa
    bat
    fd
    broot
    du-dust
    nixpkgs-fmt
    tree
    ];
}

