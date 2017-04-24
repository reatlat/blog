---
layout:       post
categories:   misc
tags:         [arch, linux]
title:        Familiarity with archlinux
feature_img:  posts/2015/03/ArchlinuxLogo2.png
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Hello world! I want to tell about the Linux-distribution Archlinux and guide you explaining the distribution of ideology. In this post, I have the example of Ubuntu will tell about advantages and disadvantages of the system and briefly tell you about the basic concepts of distribution and how it works. 

This article assumes that you have experience in working in Linux-systems, as Archlinux rather complicated distribution for beginners. All of the text I will accompany comparisons with the distribution Ubuntu. Ubuntu - because the most popular and most radically different from Archlinux distribution. I piously hope that it will help the reader to assimilate the information easier.

### A bit about the Arch

What Archlinux different from Ubuntu? Ubuntu - This is a complete package from the finished work environment and installed software. After installing the same Archlinux you get naked console, and then you install only what you will need. I quote from [WiKi Archlinux][0].

> Simplicity is the ultimate sophistication. — Leonardo da Vinci 

> Simplicity is absolutely the principal objective behind Arch development. Many GNU/Linux distributions define themselves as "simple." However, simplicity itself has many definitions. 

> Arch Linux defines simplicity as without unnecessary additions, modifications, or complications, and provides a lightweight UNIX-like base structure that allows an individual user to shape the system according to their own needs. In short: an elegant, minimalist approach.

> Complexity without complication.

> Simplicity of implementation, code-elegance, and minimalism shall always remain the reigning priorities of Arch development. 

> Arch Linux targets and accommodates competent GNU/Linux users by giving them complete control and responsibility over the system.

> Arch Linux uses simple tools, that are selected or built with openness of the sources and their output in mind.

> By keeping the system simple, Arch Linux provides the freedom to make any choice about the system.

This opens up unlimited space for imagination and the ability to do what you want, and not as dictated by the creator of the distribution.

Ideology Archlinux, this whole religion, with its fanatics. Like me for example. Read more "The Arch Way" to understand the meaning of this distribution.

### Sofware in ArchLinux

In my opinion, the software for the most part determine the distribution. What is known Debian and Ubuntu? The fact that you can put a team a little if not any software from the world of OpenSource, but not so on RPM-distributions. In addition to everything on Ubuntu is really a lot, PPA repositories with the freshest software. This allows you to install any software and do not deal with it Building from source and explores the deb / rpm packages. Just in Ubuntu there is a beautiful package manager apt, which is the heart of the system and allows you to manage packages with such ease that Windows users silently envy. What are we surprised by Arch?

#### Model update Rolling release

Most people are used to the standard model updates. First release system is available either Windows or Ubuntu, and then you come to a minor update with security patches or bug fixes. In Arch are all a little different. There is no concept of the release system in principle. Packets appear daily, and you can use the latest versions immediately. This is so to speak a constantly updated distribution, from what is lost neobhost make new versions in the form of installation images.


![](/assets/posts/2015/03/pacman.png)

#### Pacman and AUR

At Arch has a binary package manager and name him Pacman. How does it differ from Apt in Ubuntu?

1. Speed. It is so fast that you feel apt past century. When on older machines apt brakes - Pacman works at the speed of light.
2. Management. Pacman has no GUI, but he laid out on so much good that need to interface simply disappears. Of course there is an opportunity to put GUI, but eventually you no longer need to use it.
3. Dependence. Ideology distribution implies simplicity and elegance in everything from what to Pacman depending made so that when you install any software to be used depending only needed for the program. Let us examine this in the example of the archiver. For example, set in any of the Ubuntu GUI archiver and depending we will obtain any additional software, such as zip, unrar and other. What if I use tar archives and I do not need zip and rar? Pacman also install only archiver and displays a list of recommended dependencies including all possible archive formats. In Ubuntu, this is not possible, even with the use --no-recommends-install

Pacman way contains not so many packages and is not always possible to establish that there is a standart repositories Ubuntu, but there is such a wonderful thing as AUR.

So, what is the AUR? AUR (Arch User Repository) - supported intuziasty repository containing scripts to automatically build applications from source. Everyone has the right to enjoy the application to add to the repository AUR. If the package in AUR accumulates a certain number of votes it gets in Official repository. AUR - a place where you can find almost everything. Members are constantly adding a number of new and update old packages that compensates for the meager Official repository.

### Configuration

All that is in Archlinux - can be customized. Any adjustments are made through the distribution configuration files, instead of GUI-programs in Ubuntu. Again, we have the ability to customize all exactly as we want without resorting to GUI. Why to configure the system to use the little functional GUI, when everything can be done through the configs? (stone in the garden Ubuntu Tweaker and other muti). On the other hand, it is extremely difficult to do for novice users, but it's not about us.

### Search information

In Archlinux has its own Wiki, where you can learn 95% of the information on the system and little if not everyone in it. The remaining 5% of the data fall into the first search string from the official forum.

### Conclusion

Arch Linux is a designer from which to collect at least a simple system for slower machines and filling systems software to run on powerful machines than. Arch takes time for the initial development of the distribution, but this is offset by the fact that it is much better amenable to configure than eg Ubuntu.
Installing ArchLinux difficult the first time to install the system, at least have to read before installing [Beginners Guide][1] from the wiki. Since the concept as a standard installation Ubuntu, it is not. To install will have to make many decisions and to prescribe a set of parameters. If everything is done correctly, you will get a system without unnecessary waste.


[0]: https://wiki.archlinux.org/
{:rel="nofollow" target="_blank"}

[1]: https://wiki.archlinux.org/index.php/Beginners%27_guide
{:rel="nofollow" target="_blank"}