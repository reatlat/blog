---
layout:       post
categories:   misc
tags:         [arch, gstreamer, linux, mp3, pacman]
title:        Gstreamer add missing plugins on Arch
description:  description
feature_img:  2015/03/Gstreamer-logo.png
---

This is for an ArchLinux or Arch based linux distro.

You may encounter the below error when its your first time setting up an arch distro.
GStreamer could not create the element: autoaudiosink.

> Please make sure that you have installed all necessary GStreamer plugins (e.g. OGG and MP3)

To resolve this problem and save you time from figuring out what packages are needed for audio files, run below command then test your audio files after successful installation of packages.

```sh
sudo pacman -S --needed --noconfirm gstreamer0.10-{bad,good,ugly}{,-plugins} gstreamer0.10-python gst-plugins-{base{,-libs},good,ugly} gst-libav gstreamer0.10-ffmpeg ffmpeg{,-compat} phonon-qt{4,5}-gstreamer
```

Credits to: [FadeMind][0]

[0]: https://forum.manjaro.org/index.php?PHPSESSID=shb4r7b4p8t6q2o1sc36acvie4&topic=7690.msg126515#msg126515
{:rel="nofollow" target="_blank"}
