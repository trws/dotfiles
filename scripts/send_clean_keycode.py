#!/usr/bin/env python3
"""
takes arguments of the form <modifiers> <key>
where modifiers is a comma-separated list of modifiers and key is a single key
by keycode name
"""
import AppKit as ak
import Quartz as q
from typing import Union, Optional, List
import sys
import time


if len(sys.argv) != 3:
    print("requires two positional arguments, modifiers and key")
    sys.exit(1)

# for a in sys.argv:
#     a.split('=')
# flags = ak.NSEvent.modifierFlags()
# if
# print()

keycodes = {}
modifiers = {
    "Shift" : q.kCGEventFlagMaskShift,
    "S" : q.kCGEventFlagMaskShift,
    "Alt" : q.kCGEventFlagMaskAlternate,
    "A" : q.kCGEventFlagMaskAlternate,
    "Meta" : q.kCGEventFlagMaskAlternate,
    "M" : q.kCGEventFlagMaskAlternate,
    "Option" : q.kCGEventFlagMaskAlternate,
    "Control" : q.kCGEventFlagMaskControl,
    "C" : q.kCGEventFlagMaskControl,
    "Command" : q.kCGEventFlagMaskCommand,
    "D" : q.kCGEventFlagMaskCommand,
    "Fn" : q.kCGEventFlagMaskSecondaryFn,
    "F" : q.kCGEventFlagMaskSecondaryFn,
}

src = q.CGEventSourceCreate(q.kCGEventSourceStateHIDSystemState)
loc = q.kCGHIDEventTap

class Key(object):
    def __init__(self, code : Optional[int] = None, name : Optional[str] = None, mods : Union[List[str],str] = []):
        self.code = None
        if code is not None:
            self.code = code
        elif name is not None:
            self.code = keycodes[name]

        if self.code is None:
            raise TypeError()

        self.downevent = q.CGEventCreateKeyboardEvent(src, self.code, True)
        self.upevent = q.CGEventCreateKeyboardEvent(src, self.code, False)

        if isinstance(mods, str):
            mods = mods.split(',')
        mask = modifiers[mods[0]] if len(mods) > 0 else 0
        for m in mods:
            mask = mask | modifiers[m]

        q.CGEventSetFlags(self.downevent, mask)
        q.CGEventSetFlags(self.upevent, mask)


    def post_up(self):
        q.CGEventPost(loc, self.upevent)

    def post_down(self):
        q.CGEventPost(loc, self.downevent)

    def __str__(self):
        return "0x%02x" % self.code
    def __repr__(self):
        return "0x%02x" % self.code

def doit():
    key = Key(name=sys.argv[2], mods=sys.argv[1])

    print(key)

    # for m in mods:
    #     m.post_down()
    key.post_down()
    key.post_up()
    # for m in mods:
    #     m.post_up()



keycodes = {
    "A" : 0x00,
    "S" : 0x01,
    "D" : 0x02,
    "F" : 0x03,
    "H" : 0x04,
    "G" : 0x05,
    "Z" : 0x06,
    "X" : 0x07,
    "C" : 0x08,
    "V" : 0x09,
    "B" : 0x0B,
    "Q" : 0x0C,
    "W" : 0x0D,
    "E" : 0x0E,
    "R" : 0x0F,
    "Y" : 0x10,
    "T" : 0x11,
    "1" : 0x12,
    "2" : 0x13,
    "3" : 0x14,
    "4" : 0x15,
    "6" : 0x16,
    "5" : 0x17,
    "Equal" : 0x18,
    "9" : 0x19,
    "7" : 0x1A,
    "Minus" : 0x1B,
    "8" : 0x1C,
    "0" : 0x1D,
    "RightBracket" : 0x1E,
    "O" : 0x1F,
    "U" : 0x20,
    "LeftBracket" : 0x21,
    "I" : 0x22,
    "P" : 0x23,
    "L" : 0x25,
    "J" : 0x26,
    "Quote" : 0x27,
    "K" : 0x28,
    "Semicolon" : 0x29,
    "Backslash" : 0x2A,
    "Comma" : 0x2B,
    "Slash" : 0x2C,
    "N" : 0x2D,
    "M" : 0x2E,
    "Period" : 0x2F,
    "Grave" : 0x32,
    "KeypadDecimal" : 0x41,
    "KeypadMultiply" : 0x43,
    "KeypadPlus" : 0x45,
    "KeypadClear" : 0x47,
    "KeypadDivide" : 0x4B,
    "KeypadEnter" : 0x4C,
    "KeypadMinus" : 0x4E,
    "KeypadEquals" : 0x51,
    "Keypad0" : 0x52,
    "Keypad1" : 0x53,
    "Keypad2" : 0x54,
    "Keypad3" : 0x55,
    "Keypad4" : 0x56,
    "Keypad5" : 0x57,
    "Keypad6" : 0x58,
    "Keypad7" : 0x59,
    "Keypad8" : 0x5B,
    "Keypad9" : 0x5,
    "Return" : 0x24,
    "Tab" : 0x30,
    "Space" : 0x31,
    "Delete" : 0x33,
    "Escape" : 0x35,
    "F17" : 0x40,
    "VolumeUp" : 0x48,
    "VolumeDown" : 0x49,
    "Mute" : 0x4A,
    "F18" : 0x4F,
    "F19" : 0x50,
    "F20" : 0x5A,
    "F5" : 0x60,
    "F6" : 0x61,
    "F7" : 0x62,
    "F3" : 0x63,
    "F8" : 0x64,
    "F9" : 0x65,
    "F11" : 0x67,
    "F13" : 0x69,
    "F16" : 0x6A,
    "F14" : 0x6B,
    "F10" : 0x6D,
    "F12" : 0x6F,
    "F15" : 0x71,
    "Help" : 0x72,
    "Home" : 0x73,
    "PageUp" : 0x74,
    "ForwardDelete" : 0x75,
    "F4" : 0x76,
    "End" : 0x77,
    "F2" : 0x78,
    "PageDown" : 0x79,
    "F1" : 0x7A,
    "LeftArrow" : 0x7B,
    "RightArrow" : 0x7C,
    "DownArrow" : 0x7D,
    "UpArrow" : 0x7,
    "Command" : 0x37,
    "Shift" : 0x38,
    "CapsLock" : 0x39,
    "Option" : 0x3A,
    "Control" : 0x3B,
    "RightShift" : 0x3C,
    "RightOption" : 0x3D,
    "RightControl" : 0x3E,
    "Function" : 0x3F,
}

doit()
