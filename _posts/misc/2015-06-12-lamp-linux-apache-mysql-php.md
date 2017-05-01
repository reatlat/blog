---
layout:       post
categories:   misc
tags:         [lamp, linux, apache, mysql, php, arch]
title:        LAMP — Linux + Apache + MySQL + PHP
feature_img:
  source: posts/2015/06/lamp.gif
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Apache - the most popular web server. Its task like any other Web server - to send content to client requests. Apache has a great functionality through plug-ins.

```sh
$ yaourt -S apache php php-apache mariadb
```

This is the most popular variant of installation.
Thus we get the LAMP - Linux + Apache + MySQL + PHP 

After we need unstall mysql and start httpd with mysqld 

```sh
$ sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
$ systemctl start httpd.service
$ systemctl start mysqld.service
```

Do not forget to set a password for MySQL. To do this, follow these steps: 

```sh
$ /usr/bin/mysqladmin -u root password
$ /usr/bin/mysqladmin -u root -h linux password
```

Now, if you try to go without a password, you will not work: 

```sh
$ sudo mysql -u root
```

ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
Now login with password: 

```sh
$ sudo mysql -u root -p
```

In response, you will be prompted to enter the password operation.

To support MySQL, edit /etc/php/php.ini uncomment: 

```config
;extension=mysql.so
```

Make sure that the group exists and the user mysql. If not, add it manually: 

```sh
$ groupadd -g 89 mysql
$ useradd -u 89 -g mysql -d /var/lib/mysql -s /bin/false mysql
```

Change the owner of the root directory MYSQL: 

```sh
$ chown -R mysql:mysql /var/lib/mysql
```

Now check user http in /etc/shadow: 

```sh
$ cat /etc/shadow :
$ http:x:14871::::::
```

If such a line not been found, add the user manually: 

```sh
$ useradd -d /srv/http -r -s /bin/false -U http
```

Now look in /etc/hosts: # /etc/hosts: static lookup table for host names # # 
127.0.0.1 localhost.localdomain localhost your_hostname
And now we need include PHP module... For that we need edit /etc/httpd/conf/httpd.conf add in section DefaultType text/plain code shown below: 

```config
LoadModule php5_module modules/libphp5.so
Include conf/extra/php5_module.conf

AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps

AddType application/x-httpd-php .html
AddType application/x-httpd-php .htm
```

And now restart httpd...

![](/assets/posts/2015/06/2015-06-05--1433499807_768x461_scrot.png)

WTF?

For fix that go to edit /etc/httpd/conf/httpd.conf and replace: 

```config
LoadModule mpm_event_module modules/mod_mpm_event.so
```

with 

```config
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
```

and now restart httpd and enjoy =)