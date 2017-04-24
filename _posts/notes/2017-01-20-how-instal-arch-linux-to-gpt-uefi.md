---
layout:       post
categories:   notes
tags:         [linux, arch, install, guide, begine]
title:        How Instal Arch LInux to GPT UEFI
feature_img:  posts/2017/01/ArchLInux_ussr.jpg
sitemap:
  lastmod:    2017-01-20T23:08:37
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

First one download last one image from arch linux

We will create a bootable installation media of Arch Linux that we will use to install Arch on our machine.

Download the latest ISO of Arch Linux.

Plug in a USB drive into your system. Find the block device name of the drive with ‘lsblk’ command.

```sh
lsblk
```

Look at the storage capacity of each device to identify the USB drive you want to use as installation media. If you can’t identify it, unplug the drive and run the ‘lsblk’ command. Now plug the drive and run the command again. Compare the output of the command, with and without USB drive plugged in, to see identify the new block device that showed up after plugging the USB flash. That’s your device.

Use the ‘dd’ command to write the image to the USB flash drive:

```sh
sudo dd if=/path_to_arch_.iso of=/dev/sdX bs=1M
```

Replace ‘sdX’ with your block device, in my example it’s ‘sdb’.

```sh
sudo dd if=/home/swapnil/Download/archlinux-2016.12.01-dual.iso of=/dev/sdb bs=1M
```

Once the ISO has been successfully written to the USB Flash drive, edit the BIOS settings of the target computer (where you will be installing Arch Linux) and configure it to boot from the removable drive. If your system has secure boot, please disable it.

Plug your bootable Arch Linux USB Flash drive into the target PC and boot it. If everything does well, you should boot into Arch Linux boot screen. Choose ‘Boot Arch Linux (x86_64)’ from the list. It will open a command line interface.

We will be downloading all packages from the Internet to install our system. We need working network so we can connect to the Internet. If you have Ethernet cable, I will recommend using it to eliminate the complexity of setting up the wireless network. If you don’t have a wired connection, read up. Just one caveat: I am assuming that your system has well supported wireless card; otherwise you will have to install drivers manually and covering all of those is beyond the scope of this article.

First if you have spanish keyboard like me you need set you key layout

```
loadkeys es
```

Let’s run ‘ifconfig’ or ‘ip link’ command that will list all network devices.

```sh
ip link
```

Note down the name of the device you want to use. Wired devices will start with something like ‘en’ whereas wireless devices will start with ‘wl’. In my case wired device was ‘enp0s3’ and wireless devices was ‘wlp2s0’.

Run the following command to set-up the wireless device (replace wlp2s0 with the name of your wireless devices)

```sh
wifi-menu wlp2s0
```

Use arrow keys on your keyboard to select the wireless network you want to connect to and click OK (tip: mouse won’t work in the command line, hit enter or use the ‘Tab’ key to highlight the ‘Ok’ button and hit enter).

The next window will give you the option to change the name, leave it as it is. Enter the wireless password in the third window. You should be connected. Let’s ping Google to see if we are connected:

```sh
ping  -c 3 www.google.com
```

If you get output, congrats you are connected. It’s time to proceed.

Now check the new partitions and take note of their numbers:

```sh
lsblk
```

We will now format these partitions and mount them in this order:

- sda1 for /boot (512MB)
- sda2 for /root (all other space)
- sda3 for swap (16GB like size of RAM)


Now format boot partition:

```sh
mkfs.fat -F32 /dev/sda1
```

Format root partition:

```sh
mkfs.ext4 /dev/sda2
```

And then swap:

```sh
mkswap /dev/sda3
swapon /dev/sda3
```

Now it’s time to mount these partitions.

First mount root:

```sh
mount /dev/sda2 /mnt
```

Then create boot directory:

```sh
mkdir -p /mnt/boot
```

And mount the boot partition:

```sh
mount /dev/sda1 /mnt/boot
```


### Step 3: Install base packages
We will now be downloading and installing base packages. If you wish, you can edit the mirrorlist file so that you have the closest mirror set for the fastest download speed.

Edit the mirrorlist file:

```sh
nano /etc/pacman.d/mirrorlist
```

Now use the arrow key and select the mirror closest to you, I chose the US server. Then use Alt+6 to copy that URL and move the cursor on the very top of the list and paste it there (Ctrl+U). Then save and close the file (Ctrl+x).

Install the base packages:

```sh
pacstrap -i /mnt base base-devel
```

We now have to create fstab on the new system. The following command will create the file and populate it.

```sh
genfstab -U /mnt > /mnt/etc/fstab
```

We now have to configure different components. To do that we have to chroot into the new system:

```sh
arch-chroot /mnt /bin/bash
```



### Step 4: Set up boot loader
Grub is not working on this laptop so after much hunting around, I resorted to using systemd-boot in UEFI mode.

Install the bootloader:

```sh
bootctl --path=/boot install
```

Open the loader.conf file:

```sh
nano /boot/loader/loader.conf
```

And make sure only these lines are there:

```
default arch
timeout 1 
editor 0
```

Now find the UUID of root partition:

```sh
blkid -s PARTUUID -o value /dev/sda2
```

Take note of the long UUID number, and create arch.conf file:

```sh
nano /boot/loader/entries/arch.conf
```

And add these lines to the arch.conf file (exchange the PARTUUID number with the UUID number on your machine):

```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=66e3f67d-f59a-4086-acdd-a6e248a3ee80 rw
```

It’s now time to update the bootloader:

```sh
bootctl update
```

Since Dell XPS 13 uses PCIe for storage, we need to add nvme module. Edit the mkinitcpio configuration file:

nano /etc/mkinitcpio.conf

And add nvme in the MODULES line:

MODULES="nvme"

Now update the bootloader:

```sh
mkinitcpio -p linux
```

You are all set to boot into your Arch system. But we still have more work to do.

### Step 5: Set languages and time zone
I am setting up my system for US English, and choosing EDT as the time zone.

Open the locale.gen file:

```sh
nano /etc/locale.gen
```

Here you will see the list of languages. I have a trick that will save you a lot of scrolling: US English is listed on top of the list as an example, just uncomment it there: “en_US.UTF-8”

Save (Ctrl+O) and close (Ctrl+X) the file and then run the following commands:


```
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

export LANG=en_US.UTF-8
```

Set-up the time zone with this command and follow the instructions:

```sh
tzselect
```

Once done, just create a symlink to set it as localtime:

```
ln -s /usr/share/zoneinfo/Europe/Madrid  /etc/localtime
```

However, we will be using UTC for hardware clock:

```sh
hwclock --systohc --utc
```

Add real user remove -s flag if you don't whish to use zsh

```sh
useradd -m -g users -G wheel -s /bin/zsh MYUSERNAME
passwd MYUSERNAME
```

### Step 6: Create user and password
First we need to create the root password for the system so that we can perform administrative tasks as root. Run the following command and then enter a password when asked:

```sh
passwd
```

Now create a user for this system. I'm using my own name in this example:

```sh
useradd -m -G wheel,users -s /bin/bash MYUSERNAME
```

And now give this user a password:

```sh
passwd MYUSERNAME
```

If you want, you can give this user sudo powers. Install sudo package:

```sh
pacman -S sudo
```

And then run the following command:

```sh
EDITOR=nano visudo
```

Find this line and uncomment it:

```sh
%wheel ALL=(ALL) ALL
```

Now let’s give this system a decent hostname (that’s the name that will appear on the network)

```sh
echo swapnil > /etc/hostname
```

#### We now have a fully working system. But we still need GUI tools and a desktop environment.

1. Install Yaourt using a custom repository
Edit Pacman configuration file:

```sh
sudo nano /etc/pacman.conf
```

Add the following repository at the bottom:

```
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
Save and close the file.
```

Now, update repository database and install Yaourt using command:

```sh
sudo pacman -Sy yaourt
```

That’s it. Yaourt has been installed. You can now skip the next section and directly go to the Usage section at the end of this tutorial to know how to use Yaourt wrapper tool.

Or If you want to know how to install Yaourt using AUR, read on.

### Step 7: Install GNOME and complete installation
GNOME works best on the HiDPI display of this system, but you can install any DE you like. (I also like Cinnamon on it.)

```sh
pacman -S gnome gnome-extra
```

To be able to manage the network from the GUI (we have been using command line tools so far), we need to install some packages that are not part of GNOME:

```sh
pacman -S iw wpa_supplicant dialog network-manager-applet networkmanager
```

We will also install support for the touchpad:

```sh
pacman -S xf86-input-libinput
```

Now tell systemd to start GNOME Display Manager and networking at the boot time:

```sh
systemctl enable NetworkManager.service

systemctl enable gdm.service
```

Before you reboot into your new system, exit the chroot environment and then unmount the partitions that we mounted during installation:

```sh
exit
```

```sh
umount -R /mnt
```

And now reboot the system:

```sh
reboot
```

You now have brand new Arch Linux on your Laptop.


links for source.... will be edit little bit later.
https://wiki.archlinux.org/index.php/Multilib
https://wiki.archlinux.org/index.php/bumblebee
https://bbs.archlinux.org/viewtopic.php?id=209554
https://wiki.archlinux.org/index.php/Microcode
https://wiki.archlinux.org/index.php/ASUS_Zenbook_Pro_UX501
https://www.ostechnix.com/install-yaourt-arch-linux/
https://wiki.archlinux.org/index.php/ASUS_Zenbook_Pro_UX501
https://wiki.archlinux.org/index.php/Installation_guide#Testing_if_you_are_booted_into_UEFI_mode
https://bbs.archlinux.org/viewtopic.php?id=169025
http://blog.felhamed.com/arch-linux/
https://www.ostechnix.com/how-to-install-arch-linux-2016-02-01/
https://gist.github.com/mattiaslundberg/8620837
http://www.cio.com/article/3098030/linux/how-to-install-arch-linux-on-dell-xps-13-2016-in-7-steps.html#slide2
http://www.bhartiya.io/always-updated-arch-linux-tutorial/30411/4#page-content