---
layout: post
title: Is there a chance for a real assistant like jarvis for developers?
description: "A friend told me that language is not required to transform the human speech to a text"
category: assistant
tags: [machine-learning, shell, bash, linux]
comments: true
---

<img src="https://wikizilla.org/w/images/f/fd/03_03sp.jpg" width=500>

The previous image belongs to : [Pelops II](https://wikizilla.org/wiki/Pelops_II) which is a doglike artificial intelligence who appears in the 2021 animated Godzilla series, Godzilla Singular Point. 

Pelops reminded me that I have created my own assistant that can be something interesting.

## Origin

Since the first time I touched a computer, if I see a repetitive task, I needed to automate it, no matter what. I still remember one of my first portable: Dev c++. 

That necessity of automate explode when I knew the linux shell

<img src="https://www.thatcompany.com/wp-content/uploads/2019/12/power.jpg" width=500>

So, since that day I was accumulating a lot of scripts.

When I see the first Iron Movie my mind went to space, because of Jarvis

<img src="https://qph.cf2.quoracdn.net/main-qimg-3134ac1b7ea09257556d8c196e260646-lq" width=400>

So in this post I will share you my own shell assistant for linux and my plan to convert it to Jarvis.

## Shortcuts or Alias

On a UI based systems, shortcuts are the option to open programs. On linux, you could create **alias** like this:

![](https://user-images.githubusercontent.com/3322836/215395540-db9c1d5d-0921-4e77-9860-81e52cad3859.png)

So whe you enter the alias (CD in the example), the shell will execute the register commands

## More human shell

Alias don't like me. Also inspired in Iron Man movies, I was looking for something like this:

![](https://user-images.githubusercontent.com/3322836/215396914-7a30f135-bbd6-4d4d-918e-0cd66005fea9.png)

## linux-commandline-assistant

So in the 2019, I created this tool as the **Hello World** of my future Jarvis

https://github.com/jrichardsz/linux-commandline-assistant

If you follow the configuration steps you will some commands ready to use like 

![image](https://user-images.githubusercontent.com/3322836/215397891-0a2e3bb7-8284-4b06-a1a3-3085cd9e87fc.png)

and create your own commands easily

## How it works?

Just create a new script with some cool name like **foo.sh** and instantly you can use it

```
jarvis foo
```

## Alternatives

I found these, but I think they are so simples

- https://github.com/MinhajAnsari/Voice-Assistant-for-Linux
- https://github.com/santoshakil/Smart-Voice-Assistant-for-Linux

## Next Feature 1

I want to add a feature to be able to execute the commands with my voice

## Next Feature 2

Using some machine learning program I want to be able to use more human commands instead static or hardcoded strings

## Next Feature 3

Create a framework in which developers could collaborate with useful commands

## Conclusion

I will try to generate a project in Indiegogo or Kickstarters to see if I found some incentive. If not, I will do it slowly but surely