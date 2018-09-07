#!/bin/bash
set -e
pgrep -fl 'openconnect.*9052'
[[ $1 = "storm" ]]
