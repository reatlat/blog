---
layout:       post
categories:   misc
tags:         [arch, CUPS, linux, printer]
title:        installing CUPS 2 on Arch
description:  description
feature_img:  2015/04/cups.png
---

We need the packages from the repository community 
- [cups][0] - the actual CUPS daemon
- [ghostscript][1] - (optional) PostScript interpreter
- [gsfonts][2] - GhostScript standard Type1 fonts

Then, try enabling and starting cups. (Three symlinks should be created.)
systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service
Here is my current (working) configuration:

```sh
$ find /etc/systemd/system/ -iname "*cups*"
/etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket
/etc/systemd/system/printer.target.wants/org.cups.cupsd.service
/etc/systemd/system/multi-user.target.wants/org.cups.cupsd.path
```

That's all, you can start setting up your printer.

[0]: https://www.archlinux.org/packages/?name=cups
{:rel="nofollow" target="_blank"}

[1]: https://www.archlinux.org/packages/?name=ghostscript
{:rel="nofollow" target="_blank"}

[2]: https://www.archlinux.org/packages/?name=gsfonts
{:rel="nofollow" target="_blank"}
