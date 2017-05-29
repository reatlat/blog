---
layout:       post
categories:   misc
tags:         [chromium, linux, security, tweak]
title:        How to Set Chromium into Private (Incognito) Mode by Default
feature_img:
  source: posts/2015/04/Chromium-Private.png
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
uuid: 83f5e2d0-f09a-4c87-8412-36f43c5430da
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
