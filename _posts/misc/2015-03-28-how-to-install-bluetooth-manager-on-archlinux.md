---
layout:       post
categories:   misc
tags:         [arch, bluetooth, linux, yaourt]
title:        How to install bluetooth manager on Archlinux
feature_img:
  source: posts/2015/03/bluetooth.png
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
uuid: afcb33a4-5543-463d-bd60-3ff35fc6d473
---

If you have bluetooth and want to use it on Archlinux you need to install the packages. Bluetooth on linux using Bluez protocol stack.

On archlinux you need to install these packages:

```sh
$ yaourt -S bluez blueman
```

If done, then enable the service.

```sh
$ sudo systemctl enable bluetooth.service
$ sudo systemctl restart bluetooth.service
```

Then make autostart application "blueman-applet" on your desktop environment or window manager that you use.

After all these manipulations you have a working blueman-manager

![](/assets/posts/2015/03/blueman.png)

That's it enjoy.