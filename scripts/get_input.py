#!/usr/bin/env python3
import tkinter.simpledialog as sd
import tkinter
root = tkinter.Tk()
root.withdraw()
from os import system
from platform import system as platform

# set up your Tk Frame and whatnot here...

if platform() == 'Darwin':  # How Mac OS X is identified by Python
    system('''/usr/bin/osascript -e 'tell app "Finder" to set frontmost of process "Python" to true' ''')
print(sd.askstring("title","prompt"))
