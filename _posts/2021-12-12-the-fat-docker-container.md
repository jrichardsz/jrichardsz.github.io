---
layout: post
title: The fat docker container
description: "how to start several process in one docker container"
category: devops
tags: [docker]
comments: true
---

Some guy wanted to know how start several process in one docker container:

- https://stackoverflow.com/questions/70308825/how-to-package-several-services-in-one-docker-image/70326121#70326121

![](https://i.ytimg.com/vi/rkvCFgKvl2I/maxresdefault.jpg)

# Let's start!!

We can start several process in one docker container, but **you should not do it**

According to the [Docker official](https://stackoverflow.com/a/58387258/3957754) docs:

> It is generally recommended that you separate areas of concern by using one service per container

Also check this:

- https://stackoverflow.com/a/68593731/3957754

# docker-compose is enough

docker-compose exist just for that: Run several services with one click (minimal configurations) and commonly in the same server.

# foreground process

In order to works a docker container needs a **foreground process**. To understand what is this, check the following links. As a extremely summary we can said you that a foreground process is something that when you launch it using the shell, the shell is taken and you can and you cannot enter more commands. You need to press `ctrl + c` to kill the process and get back your shell.

- https://unix.stackexchange.com/questions/175741/what-is-background-and-foreground-processes-in-jobs
- https://linuxconfig.org/understanding-foreground-and-background-linux-processes

# The "fat" container

Anyway, if you want to join several services or process in one container (previously an image) you can do it with **supervisor**.

[Supervisor](http://supervisord.org/) could works a our foreground process. Basically you need to register one or many linux processes and then, supervisor will start them.

## how to install supervisor

```
sudo apt-get install supervisor
```

source: https://gist.github.com/hezhao/bb0bee800531b89d7be1#file-supervisor_cmd-sh

## add single config: /etc/supervisor/conf.d/myapp.conf

```
[program:myapp]
autostart = true
autorestart = true
command = python /home/pi/myapp.py
environment=SECRET_ID="secret_id",SECRET_KEY="secret_key_avoiding_%_chars"
stdout_logfile = /home/pi/stdout.log
stderr_logfile = /home/pi/stderr.log
startretries = 3
user = pi
```
source: https://gist.github.com/hezhao/bb0bee800531b89d7be1

## start it

```
sudo supervisorctl start myapp
sudo supervisorctl tail myapp
sudo supervisorctl status
```

In the previous sample, we are used supervisor to start a python process.

    # multiple process with supervisor

You just need to add more [program] sections to the config file:

```
[program:php7.2]
command=/usr/sbin/php-fpm7.2-zts
process_name=%(program_name)s
autostart=true
autorestart=true

[program:dropbox]
process_name=%(program_name)s
command=/app/.dropbox-dist/dropboxd
autostart=true
autorestart=true
```

Here some example used in docker, just like your requirement_ Several process in one container:

- canvas lms : Basically starts 3 process: postgress, redis and a ruby app
  - https://github.com/harvard-dce/canvas-docker/blob/master/assets/supervisord.conf
- ngnix + php + ssh
  - https://gist.github.com/pollend/b1f275eb7f00744800742ae7ce403048#file-supervisord-conf
- nginx + php
  - https://gist.github.com/lovdianchel/e306b84437bfc12d7d33246d8b4cbfa6#file-supervisor-conf
- mysql + redis + mongo + nginx + php
  - https://gist.github.com/nguyenthanhtung88/c599bfdad0b9088725ceb653304a91e3

Also you could configure a web dashboard:

- https://medium.com/coinmonks/when-you-throw-a-web-crawler-to-a-devops-supervisord-562765606f7b

Another samples with docker + supervisor:

- https://gist.github.com/chadrien/7db44f6093682bf8320c
- https://gist.github.com/damianospark/6a429099a66bfb2139238b1ce3a05d79
