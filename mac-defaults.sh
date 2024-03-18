#!/bin/sh

# This is going to be my script for configuring a new mac, many things come from
# the following sources:
#   * https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#   * https://ss64.com/osx/syntax-defaults.html
# 
# Chances are *very* good that you don't want all of these unless you are me, or
# are using the same BetterTouchTool, Hammerspoon and Alfred setup I do, you
# have been warned.

## Dark mode
defaults write -g AppleInterfaceStyle Dark

##################################################
# Trackpad/mouse
##################################################

# turn on tap to click, for trackpad, magic mouse, external trackpad and
# pre-login
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# make trackpad fast enough
defaults write -g com.apple.trackpad.scaling -float 1.5

##################################################
# Keyboard
##################################################

# enable key repeat by disabling iPad-like special input
defaults write -g ApplePressAndHoldEnabled -bool false
# faster repeat start
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 3
# fn keys are actually fn keys
defaults write -g com.apple.keyboard.fnState -bool true

#gesture setup
set_gesture() {
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.${1}Finger${3}Gesture -int $4
  defaults write com.apple.AppleMultitouchTrackpad Trackpad${2}Finger${3}Gesture -int $4
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Trackpad${2}Finger${3}Gesture -int $4
}
# four-finger horiz swap spaces
set_gesture four Four HorizSwipe 2
# four-finger vert mission control
set_gesture four Four VertSwipe 2
# four-finger pinch for desktop and app menu
set_gesture four Four Pinch 2
# three-finger horiz back/forward
set_gesture three Three HorizSwipe 0
# three-finger vert next previous tab in btt, not sure here
set_gesture three Three VertSwipe 0
# three-finger tap default
set_gesture three Three Tap 2

##################################################
# Dock
##################################################

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Bottom right screen corner → Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 3
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

