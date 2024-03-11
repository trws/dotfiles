{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.neovim
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
  };

  users.users.scogland1 = {
      name = "scogland1";
      home = "/Users/scogland1";
    };

  home-manager.users.scogland1 = {lib, config, pkgs, ...}: {
    imports = [
      ~/.dotfiles/nix/common.nix
    ];
    home.stateVersion = "23.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      lima
      # document tools
      pandoc
      ## latex stuff
      qpdf

      # fish
      fasd
      fishPlugins.forgit
      fishPlugins.tide

      # all shells
      starship
    ];
  };
  homebrew.enable = true;
  homebrew.casks = [
    # necessities
    "iterm2"
    "mailmate"
    "neovide"
    "1password"
    ## interface
    "alfred"
    "hammerspoon"
    "bettertouchtool"


    "rstudio"
    "quarto"
    "bibdesk"
    "syncthing"
    "mactex"
    "omnifocus"
    "vanilla"

    "dash"
    "arc"
  ];
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "ProFont" ]; })
  ];
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  system.defaults.CustomUserPreferences = {
    # Key-Repeat enabled, everywhere
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    "com.microsoft.VSCode" = {
      ApplePressAndHoldEnabled = false;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
