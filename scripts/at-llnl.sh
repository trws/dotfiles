#!/bin/bash

if [ hostname | grep -e vortex 2>&1 /dev/null || \
     hostname | grep -e bolt 2>&1 /dev/null && \
      networksetup -getairportnetwork en0 2>&1 | grep LLNL ] ; then
    exit 0
fi
exit 1
