---
layout:       post
categories:   misc
tags:         [capslock, english, russian, language, keyboard, linux]
title:        Keyboard layout switching by CapsLock
feature_img:  posts/2015/04/capslock.jpg
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

As a software developer and true introvert, I type a lot.
I type for coding, I type for blogging, I type for chatting, I type for sexing ;)

My two most used keyboard layouts are English and Russian. And as I type, I want to switch the keyboard layouts fast and insensibly.

There is much better option for Linux machine: select input sources with CapsLock key, which is almost never used for its direct purpose of locking the capital case mode.

Besides it is only one single key to press, you can also press it with your left little finger, keeping your other fingers on their positions, thus not causing the break.

To switch the keyboard layout I added in **~/.config/openbox/autostart** this code:

```sh
setxkbmap -layout 'us,ru' -option 'grp:caps_toggle,grp_led: caps'
```

After using this code, Caps Lock begins to switch the keyboard layout and the LED indicate selected layout.