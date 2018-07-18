#!/usr/bin/env python

import sys
from subprocess import check_output, CalledProcessError

host = check_output("hostname", shell=True)

if 'vortex' in host:
    sys.exit(0)
if "storm" in host:
    try:
        # output = check_output('networksetup -getairportnetwork en0 2>&1 | grep LLNL', shell=True)
        output = check_output('grep -i LLNL /etc/resolv.conf', shell=True)
    except CalledProcessError as e:
        sys.exit(-1)
    sys.exit(0)
if "vpn" in host:
    sys.exit(0)
sys.exit(-1)
