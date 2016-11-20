---
layout:       post
categories:   misc
tags:         [linux, arch, ruby, rvm]
title:        "FATAL: Listen error: unable to monitor directories for changes"
description:  description
feature_img:  2016/11/nights_watch.jpg
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