{
  description = "TRWS's LOFT flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.vim
          pkgs.neovim
        ];

        users.users.scogland1 = {
          name = "scogland1";
          home = "/Users/scogland1";
        };

        home-manager.users.scogland1 = { lib, config, pkgs, ... }: {
          imports = [
            # path from root of git repo?
            ../common.nix
          ];
          home.stateVersion = "23.05";

          # Let Home Manager install and manage itself.
          programs.home-manager.enable = true;
          home.packages = with pkgs; [
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
  homebrew = {
    enable = true;
    brews = [
      "lima"
    ];
    masApps = {
      WireGuard = 1451685025;
      "1password for safari" = 1569813296;
    };
    casks = [
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

        "font-profont-nerd-font"

        # bartender replacement
        "jordanbaird-ice"
      ];
  };
        fonts.fonts = with pkgs;
          [ (nerdfonts.override { fonts = [ "FiraCode" "ProFont" ]; }) ];
        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # add karabiner
        services.karabiner-elements.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        security.pam.enableSudoTouchIdAuth = true;
        system.defaults = {
          dock.autohide = true;
          dock.mru-spaces = false;
          CustomUserPreferences = {
            # Key-Repeat enabled, everywhere
            NSGlobalDomain.ApplePressAndHoldEnabled = false;
            "com.microsoft.VSCode" = { ApplePressAndHoldEnabled = false; };
          };
        };
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."loftpro-50" = nix-darwin.lib.darwinSystem {
        modules = [ configuration home-manager.darwinModules.home-manager ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."loftpro-50".pkgs;
    };
}
