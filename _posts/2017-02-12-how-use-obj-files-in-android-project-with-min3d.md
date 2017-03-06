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

The following steps may seem illogical but works for me!!

# Steps

## Download .obj zip 

From pages like [https://www.turbosquid.com/3d-models/free-dna-3d-model/612564](https://www.turbosquid.com/3d-models/free-dna-3d-model/612564)

In this example, zip file contains:

- Face.obj
- Face.mtl
- face_eyel_hi.jpg  
- face_eyer_hi.jpg  
- face_skin_hi.jpg  
- face_sock.jpg


## Change file names

- Unzip and replace initial upper case letter if exists from .obj and .mtl file. 
  - Example : **F**ace.obj to **f**ace.obj

- Delete extensions and add obj or mtl prefixes. 

  - Example : face.obj to face_obj.obj and face.mtl to face_mtl.mlt

## Create or update mtlib reference in obj file

- Open obj file and create or update a line whit **mtlib** reference.

Example : 
  
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
   
This line is strange line: **mtllib face.mtl**. face.mtl does not exists but works. If I change it to  **mtllib face_mtl.mtl** does not work.
    
## Verify or fix texture

Open face_mtl.mtl file and verify that texture files names are correct:

Example :
```
newmtl Texture0
Ns 20
d 1
illum 2
map_Kd face_eyel_hi.jpg
Kd 0.7 0.7 0.7
Ks 0 0 0
Ka 0 0 0

newmtl Texture1
Ns 20
d 1
illum 2
map_Kd face_eyer_hi.jpg
Kd 0.7 0.7 0.7
Ks 0 0 0
Ka 0 0 0
```

## Use obj file with android and Min3D

Using this template project, just put files in :

- **res/raw** obj and mtl files
- **res/drawable** texture jpg files.

Run in your device or android emulator. This should look like:

![face_rotation]({{ site.url }}/images/face_obj.gif)

Enjoy it!!
