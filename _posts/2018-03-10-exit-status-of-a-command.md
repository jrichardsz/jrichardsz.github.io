---
layout: post
title: Exit status of a last command
description: "In devops, success of fauilure flag depends of return value of the last executed command"
category: linux
tags: [devops, bash, shell,linux]
comments: true  
---

First I want to bring your attention to this men :

```
$?
```

This is widely used to catch the status of the execution of any command. If is a decent command must be return **zero** for a success and a **nonzero** value for error, failure, etc. I said decent because some tools like some option of curl or sqlplus, does not do that T_T

# Success & Non Success

if you add **$?** exactly before of your line, you can get the exit status of that line. For example :

If your command is:

```
ls 145
```

Console message is : **ls: cannot access '145': No such file or directory**

And if you execute this :

```
echo $?
```

Console shows you : **2**. Which means an error, failure or something that did not end well.

But if your command is :

```
ls /tmp
```

And /tmp exist, console shows you a list of files and folders inside **/tmp**. And **$?** will have a **0** value which means success.

Here another example:

![exit-status.gif]({{ site.url }}/images/exit-status.gif)

# This is, unfortunately, not always the case

![whyyyyy.jpg]({{ site.url }}/images/whyyyyy.jpg)

Some tools like sqlplus in case of success or error return **0** value. In this case, stdout or console message returned are the only way to detect if some command ends with success or failure.


# Script mode

```
page_detect() {
  curl github.com
  status=$?
}

echo "exit status of curl command is:$(page_detect)"
```

or

```
STATUS=$(page_detect)

if [ $STATUS -eq 0 ]; then
	printf "success"
else
	printf "failed"
fi
```

That's it for today.
