# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Absolutely required command line tools
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
install gnu-tar
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install zsh
install zsh-completions

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install macvim --override-system-vi
tap homebrew/dupes
install homebrew/dupes/grep

install xz
install tmux

# Install other useful binaries
install ack
install pt
install ag
#install exiv2
install git
install p7zip
install tree

install lua
install luarocks

# Remove outdated versions from the cellar
cleanup
