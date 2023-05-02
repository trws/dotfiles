#!/bin/bash
set -e
pgrep -fl 'openconnect.*ocprox' || pgrep -fl "ssh.*chimera-relay"
