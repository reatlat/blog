---
layout:       post
categories:   misc
tags:         [arch, linux, pacman, yaourt]
title:        Yet AnOther User Repository Tool
feature_img:  posts/2015/04/pot-yaourt.png
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Archlinux still used console package manager pacman. Although attempts to create a GUI console remains the most convenient way to install / uninstall / update program in Archlinux.

However, due to the fact that in addition to the basic package repository, which contains only the basic package, there is AUR (ArchLinux User-community Repository - AUR), is a repository, which is not officially supported and shaped by the users Archlinux. It includes a number of exciting programs, and it is constantly updated, and find here a program is not difficult. Thus we see that we need to use already two programs to control their packages - pacman (official repository) and makepkg (to build packages from AUR). And find the program in the AUR can only be using a browser, go to AUR and search there. Naturally, the question is not about to normal (ie, not hands) to update the programs that are installed from the AUR ...

However, the problem is very much simplified by the fact that some time ago was created yaourt (translated from French - yoghurt), this package manager, which is an add-on pacman and provides the ability to search and install software from the AUR.

The official repository of yaourt does not. There are two ways to install the program.

Using a third-party repository (this is probably the only one of those cases where a party repository is used in the system). For this file /etc/pacman.conf add the line:

```sh
# /etc/pacman.conf
[archlinuxfr]
Server = http://repo.archlinux.fr/$arch
Then update the repositories and install yaourt using the command:
pacman -Syu base-devel yaourt
```

Using the AVR. It's enough to run the following commands:

```sh
pacman -S base-devel
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar zxvf package-query.tar.gz
cd package-query # makepkg -si
cd ..
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar zxvf yaourt.tar.gz
cd yaourt # makepkg -si
cd ..
```

### mini-guide to the options pacman / yaourt

|---
| **PACMAN** | **YAOURT** | **DESCRIPTION**
| pacman -S package_name/group_name | yaourt -S package_name | installation / re-installation / group name package_name / group_name; option --ignore packagename - ignoring the package when installing / upgrading; -p option displays a list of action commands without performing the action itself
| pacman -Sg group_name | yaourt -Sg group_name | a list of packages in the group group_name
| pacman -Sl repository | yaourt -Sl repository | list of all packages in the specified repository
| pacman -Sw packagename | yaourt -Sw packagename | download package packagename, without installing
| pacman -U /path/to/package.pkg.tar.xz | yaourt -U /path/to/package.pkg.tar.xz | installation package package.pkg.tar.xz file
| pacman -R package_name | yaourt -R package_name | Remove package package_name without removing dependencies, the -s option to remove dependencies, do not use other packages
| pacman -Syu | yaourt -Syua | update system, a set of options for pacman update packages from the base repositories for yaourt - also updates from the AUR
| pacman -Qu | yaourt -Qu | a list of packages for which updates are available
| pacman -Q packagename | yaourt -Q packagename | Search package packagename in the local database packages
| pacman -Ss package_name/package_desc | yaourt package_name/package_desc | Search in the basic package repository (in the AVR for yaourt) the name or description package_name package_desc
| pacman -Si package_name | yaourt -Si package_name | Information about the package package_name (extracted from the base repositories)
| pacman -Qi package_name | yaourt -Qi package_name | information on locally installed package package_name
| pacman -Ql package_name | yaourt -Ql package_name | a list of files installed by the package package_name
| pacman -Qo /path/file | yaourt -Qo /path/file | receive the package name, which owns the file path/file
| |yaourt -S --depends packagename | a list of packages that depend on packagename
| pacman -Sc | yaourt -Sc | remove from the cache /var/cache/pacman/pkg not installed packages and cached database packages
| | yaourt -G package_name | get * PKGBUILD * package package_name
| | yaourt --stats | Statistics for installed packages


Setting yaourt by using the file /etc/yaourtrc, by removing the comments from individual lines. Parameter names speak for themselves. 

Yaourt - an amazing program that simplifies the management packs so that after a while, just can not imagine how you can do without it live. Software Update incidentally produced as the official repository and from AUR (though in this case it is required to specify in the settings of yaourt, or in the AUR searched updates will not).