---
layout:       post
categories:   misc
tags:         [linux, arch, ruby, rvm]
title:        "FATAL: Listen error: unable to monitor directories for changes"
feature_img:
  source: posts/2016/11/nights_watch.jpg
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
uuid: 36469f25-dfa3-4217-9e06-ac8e1e4d03dd
---

Today I have a small issue with managment my blog in my new linux(ARCH) machine

Problem comes after I try use my rake script for create new post in this blog.

For fix this issue I just type on console code below

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

Also I have a same problem for Jekyll watch server, for fix it use command below

```sh
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system
```

Fixed =)