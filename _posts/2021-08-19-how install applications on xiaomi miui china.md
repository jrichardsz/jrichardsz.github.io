---
layout: post
title: How install applications on xiaomi miui china android?
description: "Xiaomi smartphones can no longer install google services in china"
category: android
tags: [adb]
comments: true
---

In this post I will show you how install any application on your xiaomi devices with MIUI 12 Android 11.

## Xiaomi smartphones can no longer install google services in china

Users in China have found that MIUI does not allow installing Google services in their Xiaomi devices anymore.

Google Mobile Services is required to use key Google applications, including the Google Play store. However, in China, some manufacturers do not install Google Mobile Services on their smartphones, as there are many alternative stores that have all kinds of applications available to users.

Some users who prefer Google apps and services can install them themselves. However, now MIUI users (with the newest MIUI 12.5) are reporting that they cannot install Google Mobile Services.

In a small official statement, Xiaomi says that this feature is no longer supported. We will update the post as more details become available.

Update: Xiaomi has confirmed that smartphones that do not initially come with Google’s service platform can no longer install the company’s services and applications. Most devices in China do not support GMS because Google services are banned in the country. Xiaomi did not disclose the list of models affected by this policy change, however, Redmi K30 Ultra and Redmi 10X 5G users have confirmed that they are no longer able to install Google apps.

source:

- https://www.gizchina.com/2021/02/02/xiaomi-smartphones-can-no-longer-install-google-services-in-china/

## Install using user interface

By default, in xiaomi devices, there are not included the main application related to installation of classic apps like, whatssap, facebook, etc : The play store

I downloaded a official whatssap apk and when I try to install it, just the popup exist without any error message :()

So, by default, you cannot install any apk on xiaomi devices using the user interface.

## Adb to the rescue

The good news, is that xiaomi has a valid android operative system. On my case it was MIUI 12 Android 11

![https://i.ibb.co/q7tBRTW/xiaomi-android-11-miui-12-redmi-note.png](https://i.ibb.co/q7tBRTW/xiaomi-android-11-miui-12-redmi-note.png)

If it has android, you could use ADB (android debug bridge) to do anything in your android.

**Steps**

- Install adb in your linux machine, following this post: https://jrichardsz.github.io/android/how-to-build-an-android-apk-using-only-linux-for-devops-automations
- Download any apk. I advice to use official pages or what I do is: get the apk file from a friend device using applications called: apk extractor
- Go to developer options in your android and enable an option called: **usb debug**
- connect your device using the usb port to your machine
- open the shell and execute

```
adb devices
```
- A popup should appear in your android asking you to trust or not in your laptop. Accept!
- You should see a message in the shell:

```
List of devices attached
abcdefgh	device
```
- go to the apk location or use the absolute path to install it:

```
adb install awesome.apk
```
- If you don't see any error in the shell, go to your android home and you will see your new app installed.

> INSTALL_FAILED_USER_RESTRICTED

If you get this error, you need to do the following configurations:

- Turn on Install via USB.
- This will ask you to enter a previous MI account or create a new one. Just do it!
- Try again the installation : `adb install awesome.apk`


## Google Play store

Normal users should not need shell and adb to install its games :D

Solution is to install the cornerstone of installation on android:

![https://www.gstatic.com/android/market_images/web/play_prism_hlock_2x.png](https://www.gstatic.com/android/market_images/web/play_prism_hlock_2x.png)

You just need to find an official version or just install my extracted apk:

- https://mega.nz/file/WwNCQRYB#RymPgFTflNjr4Za4fXgrbDxZwOFWprHAuO7riSa1hP0

This will be the only installation required, so follow the previous steps.

After that, any other app should be installable from the play store.

That's all

Hope it helps!
