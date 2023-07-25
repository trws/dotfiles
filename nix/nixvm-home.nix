{ lib, config, pkgs, ... }:

let
  ldEnv = {
    NIX_LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
      stdenv.cc.cc
    ];
    NIX_LD = lib.removeSuffix "\n" (builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker");
  };
  ldExports = lib.mapAttrsToList (name: value: "export ${name}=${value}") ldEnv;
  joinedLdExports = lib.concatStringsSep "\n" ldExports;
  nix-alien-pkgs = import (
    builtins.fetchTarball "https://github.com/thiagokokada/nix-alien/tarball/master"
    ) { };
in
  {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "scogland1";
  home.homeDirectory = "/home/scogland1";
  imports = [
  ];
  home.sessionVariables = ldEnv;
  home.file.".vscode-server/server-env-setup".text = joinedLdExports;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # nix-ld-config.enable = true;
  # nix-ld-config.user = "scogland1";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    extraConfig=''
      runtime! plug.vim
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
  };
  programs.zsh = {
    enable = true;
    # dotDir = ".dotfiles/zsh";
    envExtra = "
    source ~/.dotfiles/zsh/zshenv-link
    source ~/.vscode-server/server-env-setup
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
    python-with-packages
    nodejs

    go_1_19

    gnumake
    ninja
    cmake
    gcc

    direnv

    hyperfine
    delta
    ripgrep
    exa
    bat
    fd
    du-dust

    kitty
    # experimental
    devbox

    sshfs
    nixpkgs-fmt
    nix-alien-pkgs.nix-alien
      # jetbrains IDEs to make remote behave
      # jetbrains.clion # not working on arm...
    ];
  }
