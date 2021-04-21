// Name:    cross_keyboard_modifiers.c
// Version: 1.0.0
// Date:    2008/09/19
// Author:  Tsan-Kuang Lee
// Site:    http://blog.tklee.org
//
// What?
//
// This program allows OS X users to use multiple keyboards at the same time. By
// default (10.5.4, as far as I know), the modifiers (CMD, CTL, SHIFT, etc.)
// only work with other keys ON THE SAME KEYBOARD.  For example, if you press
// SHIFT key and the key "a" on your laptop, you get a capital "A"; if you press
// SHIFT on your laptop keyboard and the "a" key on an external keyboard (say, a
// bluetooth keyboard), you get a lowercase "a".
//
// Why?
//
// Keyboard is my primary input device.  After long time use, I found it helpful
// if I can use one keybaord for each hand so my wrist can type in a more
// comfortable position.  Having two keyboards help me a lot; however, I learned
// to type in a way that whenever SHIFT key is needed, I'll use a different hand
// for it's combined key.  For example, I'll use left shift for SHIFT-P, but
// right shift for SHIFT-A.  This increases the speed, too. I searched
// everywhere online but couldn't find any solution that can change OS X's
// default behavior.  Therefore I had to learn how OS X handles things.
//
// How?
//
// By default, OS X keeps different modifier flags for different devices.  We
// tap into the System's event handling system and keep a local copy of the
// modifiers' flags.  Whenever a non-modifier key is pressed, we reset the
// modifers' flags with the value we keep.
//
// Credit
//
// I studied the code from the following sources.  They are very helpful. Thanks
// to their authors.
//  * alterkeys.c http://osxbook.com
//  * http://lists.apple.com/archives/quartz-dev/2007/Jan/msg00049.html
//  * http://developer.apple.com/documentation/Carbon/Reference/QuartzEventServicesRef/Reference/reference.html
//
// Usage
//
// Complile using the following command line:
//     gcc -Wall -o cross_keyboard_modifiers cross_keyboard_modifiers.c
//     -framework ApplicationServices
// Then run cross_keyboard_modifiers.  (Be sure not to let the process go into
// sleep, e.g. ctrl-z at the shell. Otherwise, you may lose your keybaord input
// because of the never wakened process.  The easiest way to do so is put it in
// the background right away, i.e. "cross_keyboard_modifiers &")
//
// You need superuser privileges to create the event tap, unless accessibility
// is enabled. To do so, select the "Enable access for assistive devices"
// checkbox in the Universal Access system preference pane.

#include <ApplicationServices/ApplicationServices.h>
#include <stdio.h>

int count_flags(CGEventFlags f)
{
  int ret = 0;
  if (f & kCGEventFlagMaskShift) {
    printf("Got: Shift\n");
    ret++;
  }
  if (f & kCGEventFlagMaskControl) {
    printf("Got: Control\n");
    ret++;
  }
  if (f & kCGEventFlagMaskAlternate) {
    printf("Got: Alternate\n");
    ret++;
  }
  if (f & kCGEventFlagMaskCommand) {
    printf("Got: Command\n");
    ret++;
  }
  if (f & kCGEventFlagMaskSecondaryFn) {
    printf("Got: SecondaryFn\n");
    ret++;
  }
  return ret;
}

// This callback will be invoked every time there is a keystroke.
CGEventRef myCGEventCallback(
    CGEventTapProxy proxy, CGEventType type, CGEventRef event, void* refcon)
{
  static CGEventFlags flags = (CGEventFlags)NULL;
  CGEventFlags new_flags = CGEventGetFlags(event);

  if (flags == (CGEventFlags)NULL) {
    flags = new_flags;
  }

  switch (type) {
  case kCGEventKeyDown:
  case kCGEventKeyUp: {
    if (type == kCGEventKeyUp)
      printf("Key up\n");
    else
      printf("Key down\n");
    int sent = count_flags(new_flags);
    int stored = count_flags(flags);
    /* printf("flags stored: %d(%llu), sent: %d(%llu)\n", stored, flags, sent,
     */
    /*     new_flags); */
    if (flags == new_flags)
      break;
    // if the key has SecondaryFn embedded, which happens for arrow keys,
    // but nothing else is there, then combine SecondaryFn with the stored
    // flags
    if (sent == 1 && new_flags & kCGEventFlagMaskSecondaryFn) {
      CGEventSetFlags(event, flags | kCGEventFlagMaskSecondaryFn);
      break;
    }
    // if the key has embedded modifiers, use them
    if (sent > 0)
      break;
    CGEventSetFlags(event, flags);
    break;
  }
  case kCGEventFlagsChanged: {
    printf("Flags changed\n");
    flags = CGEventGetFlags(event);
    count_flags(flags);
    break;
  }
  }
  return event;
}

int main(void)
{
  CFMachPortRef eventTap;
  CGEventMask eventMask;
  CFRunLoopSourceRef runLoopSource;

  // CGEventFlags oldFlags =
  // CGEventSourceFlagsState(kCGEventSourceStateCombinedSessionState);
  CGEventFlags oldFlags
      = CGEventSourceFlagsState(kCGEventSourceStateHIDSystemState);

  // Create an event tap. We are interested in key presses.
  eventMask = CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventKeyUp)
      | CGEventMaskBit(kCGEventFlagsChanged);
  eventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap, 0,
      eventMask, myCGEventCallback, &oldFlags);
  if (!eventTap) {
    fprintf(stderr, "failed to create event tap\n");
    exit(1);
  }

  // Create a run loop source.
  runLoopSource
      = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);

  CFRelease(eventTap);

  // Add to the current run loop.
  CFRunLoopAddSource(
      CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);

  // Enable the event tap.
  CGEventTapEnable(eventTap, true);

  CFRelease(runLoopSource);

  // Set it all running.
  CFRunLoopRun();

  // In a real program, one would have arranged for cleaning up.
  exit(0);
}
