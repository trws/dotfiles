#!/usr/bin/env python3

import sys
from subprocess import check_output, CalledProcessError

host = check_output("hostname", shell=True)

if b'vortex' in host:
    sys.exit(0)
if any(hn in host for hn in (b"storm", b"bolt")):
    try:
        # check_output('networksetup -getairportnetwork en0 2>&1 | grep LLNL',
        #              shell=True)
        output = check_output('grep -i LLNL /etc/resolv.conf', shell=True)
    except CalledProcessError:
        sys.exit(-1)
    sys.exit(0)
if b"vpn" in host:
    sys.exit(0)
sys.exit(-1)
