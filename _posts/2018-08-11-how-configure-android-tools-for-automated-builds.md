---
layout: post
title: How configure linux shell for automated android builds without android studio
description: "In almost all web sites there are information to compile android projects with Android Studio..."
category: android
tags: [android, devops, linux]
comments: true  
---

In almost all web sites there are information to compile android projects with Android Studio, but If I want to automate the **build**?. I mean, execute some shell commands without UI tool like Android Studio. This will be useful for devops flow with continuous server like jenkins, travis, etc

In this post I will show you how to do it... Let's start!!

![neo-shell-face](https://raw.githubusercontent.com/jrichardsz/static_resources/master/neo-shell-face.png){: .img-responsive }

# Step 1 : Download

- **JDK 8 (Jdk-8u171-linux-x64.tar.gz)**

  - Option 1 : http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

- **Android Command Line Tools (sdk-tools-linux-4333796.zip)**

  - Option 1 : https://developer.android.com/studio/#downloads

  - Option 2 : https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

- **Android SDK Build Tools (build-tools_r26-linux.zip)**

  - Option 1 : https://dl.google.com/android/repository/build-tools_r26-linux.zip

  - Option 2 : https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html

- **Platform Tools (platform-tools_r26.0.0-linux.zip)**

  - Option 1 : https://dl.google.com/android/repository/platform-tools_r26.0.0-linux.zip


- **Gradle (gradle-4.5-bin.zip)**

- Option 1 : https://downloads.gradle.org/distributions/gradle-4.5-bin.zip

# Step 2 : Unzipping

Create a folder called **/opt/java/java8** and unzip the following file:

- Jdk-8u171-linux-x64.tar.gz

Create a folder called **/opt/android-sdk-linux/platform-tools/** and unzip the following files:

- platform-tools_r26.0.0-linux.zip

Create a folder called **/opt/android-sdk-linux/tools/** and unzip the following files:
- sdk-tools-linux-4333796.zip

Create a folder called **/opt/android-sdk-linux/build-tools/26.0.0/** and unzip the following files:
- build-tools_r26-linux.zip

Create a folder called **/opt/gradle/gradle-4.5/** and unzip the following files:
- gradle-4.5-bin.zip


Directories must look like :

```
/opt
├── android-sdk-linux
│   ├── platform-tools
│   │   ├── adb
│   │   ├── fastboot
│   │   ├── ...
│   ├── tools
│   │   ├── emulator
│   │   ├── monitor
│   │   ├── ...
│   ├── build-tools
│   │   ├── 26.0.0
│   │       ├── jack.jar
│   │       ├── aapt
│   │       ├── ...
├── java
│   ├── java8
│   │   ├── bin
│   │   ├── jre
│   │   ├── ---
├── gradle
│   ├── gradle-4.5
│   │   ├── bin
│   │   ├── lib
│   │   ├── ...

```

# Step 3 : Adding to PATH

Create the following environment variables:

```
export JAVA_HOME="/opt/java/java8"
export ANDROID_HOME=/opt/android-sdk-linux
export GRADLE_HOME=/opt/gradle/gradle-4.5/
```

And add them to the **path**

```
export PATH=${PATH}:$JAVA_HOME/bin
export PATH=${PATH}:$ANDROID_HOME/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_HOME/build-tools/26.0.0
export PATH=${PATH}:$GRADLE_HOME/bin
```

# Step 4 : Testing

If everything was configured correctly, the following commands must show a success message:

- java -version

Result:

```
jdk version "1.8.0_171"
JDK Runtime Environment
JDK 64-Bit Server VM
```

- gradle -version

Result:

```
----------------------
Gradle 4.5
----------------------

Build time:   2018-01-24 17:04:52 UTC
Revision:     77d0ec90636

Groovy:       2.4.12
Ant:          Apache Ant(TM) version...
JVM:          1.8.0_171 ...
OS:           Linux ...
```

# Step 5 : Android licenses

Go to your $ANDROID_HOME/tools/bin and execute:

```
./sdkmanager --licenses
```

This will ask you to accept or reject licenses. You must accept all licenses.

# That's All

Your environment is ready to build apk executing one of these commands :

```
gradle assemble
```

```
./gradlew android:assembleRelease
```

```
./gradlew android:assembleDebug
```

Also, you can execute commands from other technologies:

- React Native
- Ionic
- LibGDX

# Example

- Clone this repository : https://github.com/codepath/android_hello_world.git
- Run this command : **./gradlew android:assembleDebug**
- Check your log and you will see the apk location
- Upload to your android device and install it. Also you can use **adb** to install it.
- You must see something like :

![https://raw.githubusercontent.com/jrichardsz/static_resources/master/hello_world_android.png](https://raw.githubusercontent.com/jrichardsz/static_resources/master/hello_world_android.png){: .img-responsive }
