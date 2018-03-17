---
layout: post
title: Share files using SMB samba on linux
description: "Sometimes share a folder is necessary, so this steps are required"
category: linux
tags: [linux, bash, samba]
comments: true  
---


# Install

You need to install samba server:

sudo apt-get install samba samba-common

# Users

List linux users :

```
cut -d: -f1 /etc/passwd
```

This should contain the user you use to login in your computer. In my case is **tachikoma**.

# Prepare shared folder

Create some folder and add some multimedia files. For example : **/home/tachikoma/shared/multimedia**

Check folder owner :

```
ls -la /home/tachikoma/shared/
```

A list of folders and files inside **/home/tachikoma/shared/** are showed:

folder_attributes 1 **tachikoma** **tachikoma**  123456 Aug  5  2017 multimedia

As you can see, **tachikoma** are showed for **multimedia**. This means that the owner of this file is the same as your login. So its ready to share.

If other owner is showed, execute this :

```
chown tachikoma:tachikoma /home/tachikoma/shared/multimedia -R
```

# Edit the file /etc/samba/smb.conf


Just add the following  to the end of the file:

```
[Multimedia]
   comment = My shared folder
   read only = yes
   path = /home/tachikoma/shared/multimedia
   browsable = yes
   guest ok = yes
   force user = tachikoma
   force group = tachikoma
```

# Restart server

After that you have to (re-)start the samba server with

```
sudo service samba restart
```

or in case if error:

```
service smbd restart
```

If the samba daemon does not automatically start on system start, type the following command:

```
sudo sysv-rc-conf samba on
```

The displayed name in computers, or VLC will be **Multimedia**

Note: In the example above everyone has access to the folder without a password (guest ok = yes) but only in read-only mode (read-only = yes).

Maybe this can also help you: [https://help.ubuntu.com/lts/serverguide/samba-fileserver.html](https://help.ubuntu.com/lts/serverguide/samba-fileserver.html)

# Access shared folder from your LAN network

In the same computer or another inside LAN network, go to your folder manager and enter this in the path box :

```
smb://
```

This should show you the **domain** name. By default is :  **WORKGROUP**

Click on this domain and should be show you the username. In my case is **tachikoma**

Click on this user and a list of shared folders are showed.

- Printers
-  **Multimedia**
- etc

Observing that  **Multimedia** is the folder previously configured.

Finally click on this folder and reproduce your multimedia files or simple access your files  , previously added.

# Something funny

![funny]({{ site.url }}/images/something_funny.jpg){: .img-responsive }

In windows system, all necesary is : right click and share folder :v

# Sources

- https://elementaryos.stackexchange.com/questions/3002/how-do-i-create-a-simple-smb-file-share
- https://askubuntu.com/questions/754572/cannot-restart-samba-samba-service-is-masked
