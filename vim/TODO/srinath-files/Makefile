# rsync is like cp (copy) on steroids.  Here are some useful options:
# -C	auto ignore like CVS
# -r	recurse into directories
# -t	preserve times
# -u	update (do not overwrite newer files)
# -W	whole files, no incremental checks (default for local usage)
# --existing	only update files that already exist
# --exclude	exclude files matching the pattern
# -n	dry run (for testing)

# Usage:  after "cvs update", do
#   make install [VIMFILES=path/to/vimfiles]
# Before "cvs commit", do
#   make stallin [VIMFILES=path/to/vimfiles]
# If you have made changes in both directories, and want to keep the most
# recent versions, do
#   make sync [VIMFILES=path/to/vimfiles]
# Note:  defining VIMFILES when you invoke make overrides the value below.
# Warning:  install and stallin do not check modification times!

VIMFILES=${HOME}/.vim
EXCLUDE="--exclude='*~' --exclude='*.swp' --exclude='makefile'"

install:
	rsync -CrtW ${EXCLUDE} ftplugin/ ${VIMFILES}/ftplugin/

# stallin = reverse install
# If you can think of a better name for this target, be my guest!
stallin:
	rsync -CrtW --existing ${VIMFILES}/ .

sync:
	rsync -CrtuW ${EXCLUDE}	. ${VIMFILES}
	rsync -CrtuW --existing ${VIMFILES}/ .
