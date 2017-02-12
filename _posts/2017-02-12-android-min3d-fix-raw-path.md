---
layout: post
title: Fix Raw path of Min3D examples
description: "Fix Raw path of Min3D examples"
category: android
tags: [java, android, min3d, 3d]
comments: true  
---

Continuing with testing of 3d android frameworks, I founded this repo:

[https://code.google.com/archive/p/min3d/](https://code.google.com/archive/p/min3d/)

After some hours, I could compile and run in my android device:

[![videotutorial](https://raw.githubusercontent.com/jrichardsz/videotutoriales/master/global-resources/images/WebMole_Youtube_Video_custom_001.png)](https://www.youtube.com/watch?v=NTeIn3dVi9c){:target="_blank"}

This repo is awesome but it's examples has some points "strange" that I fixed :D

## min3d.sampleProject1:raw/camaro_obj

<script src="https://gist.github.com/jrichardsz/56e832ecc5f46e196f71fd55ba09ffdb.js"></script>

**min3d.sampleProject1:raw/camaro_obj** is the path of obj file. When I tried to run this examples I had this problem :

```
ERROR No package identifier when getting value for resource number 
```

This is because string **min3d.sampleProject1** must be the initial package that was setting at the creation project moment.
After some hours, and a little experience in android i could see that this string **min3d.sampleProject1** is related to path for raw files insise **res** folder.

So I created a util class to get this path:

<script src="https://gist.github.com/jrichardsz/1c24501766ed02c6049ce2bc5696d5eb.js"></script>

And worked perfectly :D

<script src="https://gist.github.com/jrichardsz/dc1c405f06d41d1583bba79c83ea24cc.js"></script>

HTH.

System.exit(0)
