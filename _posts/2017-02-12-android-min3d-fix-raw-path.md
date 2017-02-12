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

```java
IParser parser = Parser.createParser(Parser.Type.OBJ, getResources(), "min3d.sampleProject1:raw/camaro_obj", true);
```

**min3d.sampleProject1:raw/camaro_obj** is the path of obj file. When I tried to run this examples I had this problem :

```
ERROR No package identifier when getting value for resource number 
```

This is because string **min3d.sampleProject1** must be the initial package that was setting at the creation project moment.
After some hours, and a little experience in android i could see that this string **min3d.sampleProject1** is related to path for raw files insise **res** folder.

So I created a util class to get this path:

```java

public static String getGlobalResourcePackageIdentifier(Context context) {
    String packageName = context.getPackageName();
    PackageManager pm = context.getPackageManager();
    try {
        ApplicationInfo ai = pm.getApplicationInfo(packageName, 0);
        String apk = ai.dataDir;
        return apk.substring(apk.lastIndexOf(File.separator)+1);
    } catch (Throwable x) {
        Log.i(ResourceUtils.class.getCanonicalName(),"Failed when try to get global package identifier");
    }
    return null;
}


```

And worked perfectly :D

```java
IParser parser = Parser.createParser(Parser.Type.OBJ,
		getResources(), ResourceUtils.getGlobalResourcePackageIdentifier(this.getBaseContext())+":raw/camaro_obj", true);
```

HTH.

System.exit(0)
