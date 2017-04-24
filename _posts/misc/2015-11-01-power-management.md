---
layout:       post
categories:   misc
tags:         [arch, linux, power, systemd, tweak]
title:        Power management
feature_img:  posts/2015/11/systemd-meme.jpg
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---


I work at a laptop and often need to close it and take in another room, but the laptop goes into sleep mode.
I do not like it, so why I am a little edited configuration /etc/systemd/logind.conf.
Also, I changed the behavior of the power button.

Now, by pressing the power button, еру computer goes into sleep mode.
Below you can see my configuration.

```config
#  /etc/systemd/logind.conf

[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
HandlePowerKey=suspend
#HandleSuspendKey=suspend
#HandleHibernateKey=hibernate
HandleLidSwitch=ignore
#HandleLidSwitchDocked=ignore
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#HoldoffTimeoutSec=30s
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RemoveIPC=yes
```

