#!/bin/bash

if [ hostname | grep -e vortex -e bolt -e abrams 2>&1 /dev/null || \
      networksetup -getairportnetwork en0 2>&1 | grep LLNL ] ; then
    exit 0
fi
exit 1
