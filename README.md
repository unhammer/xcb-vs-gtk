haskell-gi crash test case


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
