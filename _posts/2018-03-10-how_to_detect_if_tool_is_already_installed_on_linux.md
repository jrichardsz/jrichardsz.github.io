---
layout: post
title: Detecting executables in linux
description: "How to detect if tool is already installed on linux?"
category: devops
tags: [devops, bash, shell]
comments: true  
---

In other post I will show you how


# Status

Check this post to learn about **exit status** :

[https://jrichardsz.github.io/linux/exit-status-of-a-command](https://jrichardsz.github.io/linux/exit-status-of-a-command)


# sdout stderr

Check this post to learn about **exit status** :

[https://jrichardsz.github.io/java/stdout-stderr-in-devops](https://jrichardsz.github.io/java/stdout-stderr-in-devops)



# sudo

Now is the turn of **sudo**. Almost all tools needs this permission. So I needed detect if sudo are allowed. This line do that:


```sh
sudo -nv
```

If this line is executed from a root user, does not return anything, but if a user with no privileges , return this :

```sh
sudo: a password is required
```

And thanks to Duke god, status is a nonzero value, so ...

```sh
sudo_detect() {
  prompt=$(sudo -nv > /dev/null 2>&1)
  status=$?
  echo $status
}

if [ "$(sudo_detect)" -eq "0" ]; then
  echo "sudo is allowed"
else
  echo "sudo is not allowed. Bye!"

```

Check this post

[https://jrichardsz.github.io/java/stdout-stderr-in-devops](https://jrichardsz.github.io/java/stdout-stderr-in-devops)

to learn about **> /dev/null 2>&1** :

# Other example : Detect Java

```sh
java_detect() {
  java_version=$(java -version > /dev/null 2>&1)
  status=$?
  echo $status
}

if [ "$(java_detect)" -eq "0" ]; then
  echo "java is installed"
else
  echo "java is not installed"

```

That's it for today.
