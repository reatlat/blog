---
layout:       post
categories:   misc
tags:         [chromium, linux, security, tweak]
title:        How to Set Chromium into Private (Incognito) Mode by Default
description:  description
feature_img:  2015/04/Chromium-Private.png
---

If you like Chromium and keeping your browsing private, use Incognito mode. you can always use that mode by clicking "New incognito window" from the menu or by just pressing Ctrl + Shift + N. 

However here’s a handy trick for always starting Chromium in incognito mode by default.
First, edit Chromium.desktop which is located here **/usr/share/applications/chromium.desktop.**

I"m using nano here, so the command will be :

```sh
sudo nano /usr/share/applications/chromium.desktop
```

In this code :

```
Exec=chromium %U add --incognito
```

so It will be 

```
Exec=chromium --incognito %U
```

Now when you open Chromium, It will open in incognito mode. 
