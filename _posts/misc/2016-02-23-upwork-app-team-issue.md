---
layout:       post
categories:   misc
tags:         [upwork, linux, error, fix]
title:        UpWork App team Issue
feature_img:
  source: posts/2016/02/reatlat.net_upwork.png
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
uuid: 841c652d-8a66-4477-b2db-3f93bf97acb3
---

Today I experienced a problem with UpWork App team tracker.
My time tracker stopped working.
What have not I tried, until he noticed that the problem in the updated library.

In ubuntu 15.10 issue resolved by downgrading libnss3 package to 3.19. This can be done by entering these commands
(for 64bit)

```sh
sudo dpkg --force-all -r libnss3
wget http://security.ubuntu.com/ubuntu/pool/main/n/nss/libnss3_3.19.2.1-0ubuntu0.15.10.2_amd64.deb sudo dpkg -i libnss3_3.19.2.1-0ubuntu0.15.10.2_amd64.deb
```

(for 32bit)

```sh
sudo dpkg --force-all -r libnss3
wget http://security.ubuntu.com/ubuntu/pool/main/n/nss/libnss3_3.19.2.1-0ubuntu0.15.10.2_i386.deb sudo dpkg -i libnss3_3.19.2.1-0ubuntu0.15.10.2_i386.deb
```

Then upwork starts to work properly.
To prevent libnss updating, no more error after ubuntu update:

```sh
sudo apt-mark hold libnss3 libnss3-nssdb
```

That's all for now!