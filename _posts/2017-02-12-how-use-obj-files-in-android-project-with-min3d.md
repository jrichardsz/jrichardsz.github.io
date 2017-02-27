---
layout: post
title: How use (.obj) Files in Android Projects whit Min3D Framework
description: "In this post I show you how use obj files in android project using min3d framework"
category: android
tags: [java, android, min3d, 3d]
comments: true  
---

Continuing with testing of 3d android frameworks, finally I could understand how use a .obj file in android.

<img src="http://img.freepik.com/free-icon/obj-open-file-format_318-45196.jpg" width="150">

# Steps

- Download .obj zip from pages like [https://www.turbosquid.com/3d-models/free-dna-3d-model/612564](https://www.turbosquid.com/3d-models/free-dna-3d-model/612564)
 
- Unzip and replace initial upper case letter if exists from .obj and .mtl file.
  - Example : **F**ace.obj to **f**ace.obg


- Delete extensions and add obj or mtl prefixs. 

  - Example : face.obj to face_obj and face.mtl to face_mtl
  
- Open obj file and fix **mtlib** reference.

  - Example : 
  
    This
    ```
      mtllib /dir/some_dir/face.mtl
      o FaceGen
      g eyeL_hi
      s 1
      v 28.1446 41.1304 43.5008
      v 23.2692 38.3366 41.7695
    ```
    
    To
    
    ```
      mtllib face.mtl
      o FaceGen
      g eyeL_hi
      s 1
      v 28.1446 41.1304 43.5008
      v 23.2692 38.3366 41.7695
    ```
   
    mtllib face.mtl is the same as : mtllib face_mtl

    comming soon...
