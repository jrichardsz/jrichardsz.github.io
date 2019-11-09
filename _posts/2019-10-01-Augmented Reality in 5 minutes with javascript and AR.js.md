---
layout: post
title: Augmented Reality in 5 minutes with javascript and AR.js
description: "Augmented Reality with AR.js"
category: development
tags: [augmented reality ar]
comments: true  
---

![https://raw.githubusercontent.com/jrichardsz/ar.js-snippets/master/logo.jpg](https://raw.githubusercontent.com/jrichardsz/ar.js-snippets/master/logo.jpg)

What would happen if the unity-3d, Unreal Engine or other advanced tools would not be necessary to develop augmented reality applications?

With this javascript library, could be possible:

- https://github.com/jeromeetienne/AR.js

I will share in this repository my new adventures with this library :D

https://github.com/jrichardsz/ar.js-snippets

Here my firs test! : **Augmented Reality in 5 minutes with javascript and AR.js**

# Steps

## 0.- Clone my repository

```
git@github.com:jrichardsz/ar.js-snippets.git
```

And go to **augmented-reality-in-5-minutes** folder

## 1.- Generate a self signed certificate

```
openssl req -x509 -newkey rsa:4096 -keyout server1.example.com.key -out server1.example.com.pem -days 365 -nodes
```

This will create **server1.example.com.key** and **server1.example.com.pem** in your folder.

## 2.- Load certificates in server.py

Modify lines 10 - 11, pointing to the absolute path of your \*.pem and \*.key and choose some port line 9

## 3.- Start mini server

Make executable to your server.py

```
chmod +x server.py
```

And run it:

```
./server.py
```

> source: https://jorge.fbarr.net/2017/06/11/simplehttpserver-with-ssl/

## 4.- Open in your smartphone, tablet or whatever

If your ip is 192.168.1.150 and your chosen port is 5000, open in your device :

https://192.168.1.150:5000

And grant camera permissions.

## 5.- Let's start the magic

If the previous url was loaded without errors, point your camera to this image

![marker](https://raw.githubusercontent.com/jrichardsz/ar.js-snippets/master/augmented-reality-in-5-minutes/hiro-marker.png)

And a yellow cube will appear:

![cube](https://raw.githubusercontent.com/jrichardsz/ar.js-snippets/master/augmented-reality-in-5-minutes/demo.png)

That's All!
