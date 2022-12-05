---
layout: post
title: How to Launch selenium firefox tests with docker?
description: "I will show you how to run selenium tests without a ton of tools in your machine"
category: quality-assurance
tags: [selenium, python]
comments: true
---

I will show you how to run selenium tests without a ton of tools in your machine. This was a result of https://stackoverflow.com/questions/67090130

![](https://user-images.githubusercontent.com/3322836/205530236-72974410-b116-44f1-9d64-fc66ff089686.png)

## Introduction

Commonly to run selenium tests, the developer has problems with its machine due its pre-installed browsers and a ton of ancient tools installed on that machine

![](https://user-images.githubusercontent.com/3322836/205528321-3ff45ff9-b1a6-4f5b-8f08-e6112e8a8715.png)

## Docker

I will show you how to run a test with docker, so your host machine could have any browser and the automation will run on another browser. After the test, everything will be deleted, so you machine will continue clean and virginal

![](https://user-images.githubusercontent.com/3322836/205528495-b3422ccf-1233-4871-acd9-f07a76180608.png)

## Steps

In the host execute this

```
xhost +
```

launch the container

```
docker run \
--rm \
-it \
--privileged \
--env DISPLAY=unix$DISPLAY \
-v $XAUTH:/root/.Xauthority \
-v /tmp/.X11-unix:/tmp/.X11-unix \
python:latest bash
```

Inside of container, download firefox, geckodriver, some tools

```
apt-get update && apt-get install -y wget bzip2 libxtst6 libgtk-3-0 libx11-xcb-dev libdbus-glib-1-2 libxt6 libpci-dev

mkdir /browsers
curl https://ftp.mozilla.org/pub/firefox/releases/61.0/linux-x86_64/en-US/firefox-61.0.tar.bz2 -o /browser/firefox-61.0.tar.bz2
tar xvf firefox-61.0.tar.bz2 -C /browsers

mkdir /drivers/
curl -L https://github.com/mozilla/geckodriver/releases/download/v0.32.0/geckodriver-v0.32.0-linux64.tar.gz -o /drivers/geckodrive.tar.gz
tar -xzvf /drivers/geckodrive.tar.gz -C /drivers/
```

create a folder and add this code **/code/app.py**

```
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
 
options = Options()
options.binary_location = '/browsers/firefox'
driver = webdriver.Firefox(executable_path='/drivers/geckodrive', options=options)
driver.get("https://jrichardsz.github.io/")
get_title = driver.title
print(get_title)
driver.close()
```

**note** the firefox binary and geckodriver location 

asdd its **/code/requirements.txt**

```
selenium==4.7.2
```

finally execute

```
cd /code/
pip install -r requirements.txt
python app.py
```

You should see a log like this and firefox will open and disappear after the test

![](https://user-images.githubusercontent.com/3322836/205530438-b31dffcb-1ad6-43ac-a5bf-d8976701ab70.png)

## Lectures

- https://www.howtogeek.com/devops/how-to-run-gui-applications-in-a-docker-container/
- https://www.esds.co.in/kb/how-to-configure-x11-display-in-linux-or-unix-troubleshoot-display-variable-issues/
- https://www.addictivetips.com/ubuntu-linux-tips/set-up-x11-forwarding-on-linux/
- https://github.com/withlazers/citrix-receiver-container/issues/1
- https://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0
- https://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0
- https://unix.stackexchange.com/questions/67111/x-cant-open-display-0-while-display-variable-is-correct
- https://www.juniper.net/documentation/en_US/nsm2012.2/topics/concept/security-service-firewall-xauth-user-authentication-overview.html