---
layout: post
title: How use (.obj) Files in Android Projects whit Min3D Framework
description: "In this post I show you how use obj files in android project using min3d framework"
category: 3D
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


## UpperCase

Due to this android restriction :
```
Error:Execution failed for task ':app:mergeDebugResources'.
> \..\..\Android3D-min3d-Face-Rotation\app\src\main\res\drawable\EyesWhite.jpg: Error: 'E' is not a valid file-based resource name character: File-based resource names must contain only lowercase a-z, 0-9, or underscore
```
We need replace any upper case letter top lower case if exists from .obj , .mtl and other resources 

  - From **F**ace.obj to **f**ace.obj

## Android ignore extensions  

This names are not allowed by android :
- Face.obj
- Face.mtl

If you saw, both files are name **Face**. Android forces us to use a unique file name. So wee need to add obj, mtl or something as to make a unique file name.  I use _suffix like :

- from face.obj to face_**obj**.obj 
- from face.mtl to face_**mtl**.mtl

## Update references

Files names are changed (images, obj and mtl),  so We need to update its refereces where using them.

## Update .obj

Obj files need a reference to .mtl files. So if our mtl file name are changed, We need update this. In some cases , .obj files use a asbolute path , so this also could be changed.

- Open obj file with some text editor and create or update a line whit **mtlib** reference.

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
   
This is quite strange : 

Real name of mtl is face_**mtl**.mtl , so reference might be
**mtllib face_mtl.mtl** but this does not work.

If I change it to  **mtllib face.mtl** works. 

It is as if min3D  ignore _mtl of file name.

Other example from my last work :
real file name : **bigmax_white_mtl.mtl**
reference in bigmax_white_obj.obj file : **mtllib bigmax_white.mtl**

Maybe this is part of documentation but I can't  find it, so this crazy workaround works!!
    
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

