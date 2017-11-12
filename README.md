# haskell-gi crash test case #


To reproduce:
```
stack build
stack exec xcb-vs-gtk
```
and try opening a file or ten.


You'll eventually get a crash with either

```
[xcb] Unknown sequence number while processing queue
[xcb] Most likely this is a multi-threaded client and XInitThreads has not been called
[xcb] Aborting, sorry about that.
xcb-vs-gtk: ../../src/xcb_io.c:259: poll_for_event: Assertion `!xcb_xlib_threads_sequence_lost' failed.
```
or
```
Gdk-Message: xcb-vs-gtk: Fatal IO error 11 (Resource temporarily unavailable) on X server :0.0.
```
or
```
Gdk-Message: xcb-vs-gtk: Fatal IO error 0 (Success) on X server :0.0.
```
or it'll just hang and need to be killed from outside.

-----

Sometimes it'll also show a [possibly harmless](https://stackoverflow.com/a/24057455/69663)
```
(xcb-vs-gtk:31194): GLib-CRITICAL **: Source ID 1904 was not found when attempting to remove it
```
(without crashing)
