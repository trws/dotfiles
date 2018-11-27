#!/usr/bin/env python

import sys
import os
from subprocess import call, check_output

host = check_output("hostname", shell=True)

if 'hurricane' in host or 'gale' in host:
    sys.exit(0)
if "typhoon" in host or "storm" in host:
    try:
        output = check_output('networksetup -getairportnetwork en0 2>&1 | grep ether', shell=True)
    except CalledProcessError as e:
        sys.exit(-1)
    sys.exit(0)
sys.exit(-1)

