#!/bin/bash
#Call out to taskgit to sync on a regular basis

#ensure that the right git is found
export PATH=/usr/local/bin:$PATH

cd ~/scripts

#sync with taskd
./taskgit sync &
TGPID=$!

if [[ ! -f sync.log ]] ; then
  touch sync.log
fi

# Rotate git.log if bigger than 1M
if [ "$(stat -c '%s' sync.log)" -gt "1000000" ]; then
  mv -f sync.log sync.log.old
  touch sync.log
fi

#let it try, but kill it if it doesn't proceed quickly
for t in $(seq 0 30) ; do
  sleep 1
  if kill -0 $TGPID ; then
    break;
  fi
  kill ${TGPID}
done


#sync with git
# ./taskgit git &
# TGPID=$!
#
# if [ ! -f sync.log ] ; then
#   touch sync.log
# fi
#
# # Rotate git.log if bigger than 1M
# if [ "$(stat -c '%s' sync.log)" -gt "1000000" ]; then
#   mv -f sync.log sync.log.old
#   touch sync.log
# fi
#
# #let it try, but kill it if it doesn't proceed quickly
# for t in $(seq 0 30) ; do
#   sleep 1
#   if kill -0 $TGPID ; then
#     break;
#   fi
#   kill ${TGPID}
# done
#
