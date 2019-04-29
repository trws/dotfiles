#!/usr/bin/env python3
import re
import fileinput

for l in fileinput.input():
    # l.rstrip()
    l = re.sub("\r\n", "\n", l)
    l = re.sub("\r", "\n", l)
    print(l,end='')
