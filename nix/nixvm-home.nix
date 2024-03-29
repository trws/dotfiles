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
in
  {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "scogland1";
  home.homeDirectory = "/home/scogland1";
  imports = [
    ~/.dotfiles/nix/common.nix
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

  home.packages = with pkgs; [
    kitty
    sshfs
      # jetbrains IDEs to make remote behave
      # jetbrains.clion # not working on arm...
    ];
  }
