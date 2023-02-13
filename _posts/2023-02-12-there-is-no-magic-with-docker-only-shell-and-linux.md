---
layout: post
title: There is no magic with Docker only shell and linux
description: "Developers thinks that devops and docker are another techniques or technologies from some part of the multiverse."
category: devops
tags: [docker, linux, shell]
comments: true
---

<img src="https://user-images.githubusercontent.com/3322836/218353839-7d3db7c8-9800-4ff8-b9c6-d17a1b350e33.png" width=500>

In several projects related to apply some devops flows or port the existing application to docker, a lot of developers (usually c#), consultants and some managers thinks that devops and docker are another techniques or technologies from some part of the multiverse.

<img src="https://user-images.githubusercontent.com/3322836/218328417-1f49dec6-b5f5-4d90-9674-7b8d49115296.png" width=500>

They don't conceive that hours of steps performed with UI desktop apps (Visual Studio for c#) could be replaced or how a wordpress could be deployed in another space different of godaddy, hostgator, bluehost, etc

So in this post I will try to explain how devops and docker are just a synonym of shell and linux.

## Problems inherited by Microsoft Windows & C#

The major problem is that until very recently, technologies related to Microsoft (C#) only Visual Studio was the only choice to build the applications.

The deployment was the same case. A human had to open the IIS server and deploy the application , which a human compiled in the Visual Studio

<img src="https://miro.medium.com/v2/resize:fit:598/format:webp/1*iyxkFF8LON5NV9B5s6uBcA.png" width=500>

So, unless you are a Unity, Windows form or C# developer, **you should not use Microsoft Windows** to develop software less for deployments.

<img src="https://user-images.githubusercontent.com/3322836/218336677-303c9463-935c-4dee-b1ff-f6ffeb0f0c45.png" width=500>

If you like modern technologies, collaboration, be part of a community and in general: The Open source World ...

<img src="https://user-images.githubusercontent.com/3322836/218337616-2c8e8182-a92c-4b89-9932-4c5aed978c86.png" width=500>

<img src="https://higherlogicdownload.s3.amazonaws.com/IMWUC/UploadedImages/nVLnEqbbROK3MYpE6Q2i_Sample%20Open-source%20software%20for%20IBM%20Z%20and%20LinuxONE%20ecosystem-L.jpg" width=500>

You should use Linux or at least Mac, but don't Windows to develop software.

## Shell compatibility

This is the first challenge. If your language, technology or framework don't provide or allow shell commands, your devops implementation has **0.0001%** chance of success.

In all of these years, only with one language and one operative system I had problems related to devops automation...

<img src="https://user-images.githubusercontent.com/3322836/218348887-7f6933ff-f109-423f-bb10-8d4118c58514.png" width=300>

I tried with [msbuild](https://docs.revenera.com/installshield22helplib/helplibrary/MSBuild_CmdLine.htm) without success.

In the rest of languages, shell commands exist from its birth and works very well. Platform for easy deployments like [Heroku](https://devcenter.heroku.com/) are a proof that only c# is complicated to automations with shell

<img src="https://user-images.githubusercontent.com/3322836/218349641-6154de63-b2b5-4195-a607-f182e1c7629e.png" width=500>


```
g++ ./foo/bar.cpp -o ./foo/bar
javac Hello.java
java Hello.class
mvn clean package
node server.js
python app.py
```

Until the legacy php (wordpress, drupal) with its apache, work fine in the shell.

So, if your language has no shell commands, forgot the automation. Maybe a kind of bot running in a windows server , opening the Visual Studio could be a solution

## Linux compatibility

Could you imagine infrastructures like whatssap, netflix, uber, etc with IIS servers & Windows server?

<img src="https://pbs.twimg.com/media/FozEGfeX0AAwFEf?format=png" width=500>

No more images or explanation here. **It's a dictatorship but a good one**. 

Linux is the only option for legacy, modern and future applications.

<img src="https://news-cdn.softpedia.com/images/news2/Google-Linux-Rocks-2.jpg" width=500>

## There is no magic

So, if your stack has shell commands to build and start. And also is compatible with Linux, you could automate the devops with :

- a simple bash script
- advanced platforms like Jenkins.
- any cloud service provided by google, amazon and azure, or third parties like Bamboo, Travis, Buddyworks, etc

## Docker

If you understand that a devops automation is possible if shell and linux exist, you could port it to docker. 

So before to think the word "Docker", try to build and start your app with pure shell and linux. If you achieve that, move to docker will be almost like copy & paste of your bash script with silent modifications

<img src="https://user-images.githubusercontent.com/3322836/218352502-a1efc340-d967-48b8-a0e6-a77976dfbcdd.png" width=500>

## Lecture and image References

- https://fractalenlightenment.com/34538/life/what-is-fear-really-trying-to-tell-us
- https://stackoverflow.com/questions/75422046/flutter-jenkins-flutter-not-found-issue/75428447#75428447
- https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/javier-perez1/2021/03/30/the-growing-ecosystem-of-open-source-software-for
- https://docs.revenera.com/installshield22helplib/helplibrary/MSBuild_CmdLine.htm
- https://news.softpedia.com/news/Google-Linux-Rocks-62279.shtml


## Conclusion

Before to think in Devops, research if your stack has shell commands and is compatible with Linux. If yes, you will be happy. If not, there are a lot of other great jobs :)