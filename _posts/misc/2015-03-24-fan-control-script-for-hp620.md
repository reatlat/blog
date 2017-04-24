---
layout:       post
categories:   misc
tags:         [arch, bash, fan, hp620, linux, script, tweak]
title:        Fan control script for hp620
feature_img:  posts/2015/03/cooling-fan-inside-laptop.jpg
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Hello world! Today I share a little note to my old laptop hp620. The fact that Arch is not correctly manages the cpu fan, and constantly running at high speed and creates a lot of noise.

Solution to the problem as it always has been found in the community forum Archlinux Forum.
This little script that I found on the forum can be viewed below.

```sh
#!/bin/bash
## Fan control for hp620

on=/sys/class/thermal/cooling_device
cur=/cur_state

while  (( 1 )) ; do

# set the sleep between each measurement and adjustment
# this options is very important to decrease the use of cpu, a value between 1s and 3s is good.
# note: don't remove this options or the cpu load will be enormous.
sleep 1.5

# reading the temperature of the core1
# this path is for an hp620 laptop, for other laptops you have to change it manually
# or wait until i add a something to detect it
## Note: here i am reading the temperature of only one core, if you want to read of them just uncomment the second line below
core1=`cat /sys/class/hwmon/hwmon0/temp2_input`
#core2=`cat /sys/class/hwmon/hwmon0/device/temp3_input`
   
## Temperature value and the fan speeds associated
## note: you can change the temp values if you find these not good
if [[ $core1 < "32000" ]] ; then
      if [[ $sp1 = '1' ]] ; then 
    echo "speed 1 aleady active."
  else
    for i in {7..7} {14..14} ; do echo 1 > ${on}${i}${cur} ; done
    for i in {6..3} {13..10} ; do echo 0 > ${off}${i}${cur} ; done
    echo "activating speed 1."
      fi
  elif [[ $core1 > "31000" && $core1 < "52000" ]] ; then
      if [[ $sp2 = '1' ]] ; then 
    echo "speed 2 aleady active."
  else
          for i in {7..6} {14..13} ; do echo 1 > ${on}${i}${cur} ; done
    for i in {5..3} {12..10} ; do echo 0 > ${on}${i}${cur} ; done
    echo "activating speed 2."
      fi
  elif [[ $core1 > "51000" && $core1 < "56000" ]] ; then
      if [[ $sp3 = '1' ]] ; then 
    echo "speed 3 aleady active."
      else
          for i in {7..5} {14..12} ; do echo 1 > ${on}${i}${cur} ; done
    for i in {4..3} {11..10} ; do echo 0 > ${on}${i}${cur} ; done
    echo "activating speed 3."
      fi
  elif [[ $core1 > "55000" && $core1 < "66000" ]] ; then
      if [[ $sp4 = '1' ]] ; then 
    echo "speed 4 aleady active."
  else
          for i in {7..4} {14..11} ; do echo 1 > ${on}${i}${cur} ; done
    for i in {3..3} {10..10} ; do echo 0 > ${on}${i}${cur} ; done
    echo "activating speed 4."
      fi
  elif [[ $core1 > "65000" ]] ; then
      if [[ $sp5 = '1' ]] ; then 
    echo "speed 5 aleady active."
  else
          for i in {7..3} {14..10} ; do echo 1 > ${on}${i}${cur} ; done
    echo "activating speed 5."
      fi
fi      


## An extra way to detect the actual fan speed to prevent the script from writing each time
## the same values, so it is like a lock
declare -a cf

# Reading the current fan speeds from "/sys/class/thermal/cooling_device$i/cur_state
for i in {0..15} ; do 
  t=`cat ${on}$i${cur}`
  cf[$i]=$t
done

## Deciding which speed is used
  if [[ ${cf[2]} = '1' && ${cf[8]} = '1' ]] ; then
      for i in {0..2} ; do echo 0 > ${on}${i}${cur} ; done
      echo 0 > ${on}8${cur}
      echo "sleep problem is ok!"
      fi
  
  if [[ ${cf[7]} && ${cf[14]} = '1' && ${cf[6]} && ${cf[5]} && ${cf[4]} && ${cf[3]} && ${cf[13]} && ${cf[12]} && ${cf[11]} && ${cf[10]} = '0' ]] ; then
      sp1=1
      else
      sp1=0
      fi

  if [[ ${cf[7]} && ${cf[6]} && ${cf[14]} && ${cf[13]} = '1' && ${cf[5]} && ${cf[4]} && ${cf[3]} && ${cf[12]} && ${cf[11]} && ${cf[10]} = '0' ]] ; then
      sp2=1
      else
      sp2=0
      fi
  if [[ ${cf[7]} && ${cf[6]} && ${cf[5]} && ${cf[14]} && ${cf[13]} && ${cf[12]} = '1' && ${cf[4]} && ${cf[3]} && ${cf[11]} && ${cf[10]} = '0' ]] ; then
      sp3=1
      else
      sp3=0
      fi
  if [[ ${cf[7]} && ${cf[6]} && ${cf[5]} && ${cf[4]} && ${cf[14]} && ${cf[13]} && ${cf[12]} && ${cf[11]} = '1' && ${cf[3]} && ${cf[10]} = '0' ]] ; then
      sp4=1
      else
      sp4=0
      fi
  if [[ ${cf[7]} && ${cf[6]} && ${cf[5]} && ${cf[4]} && ${cf[3]} && ${cf[14]} && ${cf[13]} && ${cf[12]} && ${cf[11]} && ${cf[10]} = '1' ]] ; then
      sp5=1
      else
      sp5=0
      fi
done
```

```config
[Unit]
Description=Fan control for hp620
 
[Service]
Type=simple
ExecStart=/usr/bin/hp620fan
TimeoutSec=30
SysVStartPriority=99
 
[Install]
WantedBy=multi-user.target
```

Credits to: [fuhrer][0]

[0]: https://bbs.archlinux.org/viewtopic.php?pid=1513843
{:rel="nofollow" target="_blank"}
