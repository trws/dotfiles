#!/usr/bin/env python3

import sys
import os
import re
from subprocess import call, check_output, CalledProcessError

try:
    if int(os.environ["FORCE_HOME"]):
        sys.exit(0)
except KeyError:
    pass
host = check_output("hostname", shell=True).decode()
if 'hurricane' in host or 'gale' in host:
    sys.exit(0)
if host in ("abrams", "typhoon", "storm", "bolt", "loftpro", "codex"):
    output = check_output('ifconfig', shell=True).decode()
    if re.search(r"58:ef:68:e7:39:44", output):
        sys.exit(0)
    try:
        output = check_output('networksetup -getairportnetwork en0 2>&1 | grep -e multipass', shell=True)
    except CalledProcessError as e:
        sys.exit(-1)
    sys.exit(0)
sys.exit(-1)

