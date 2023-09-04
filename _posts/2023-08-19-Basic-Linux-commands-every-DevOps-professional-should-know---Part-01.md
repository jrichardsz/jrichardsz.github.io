---
layout: post
title: Basic Linux commands every DevOps professional should know — Part 01
description: ""
category: devops
tags: [bash, linux]
comments: true
---

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*pFkbUwMZAcADJXzdLv3UtQ.png" width=500>

Image Source: https://www.amazon.com/Linux-Basics-Hackers-Networking-Scripting/dp/1593278551

--- 

Some Sunday I saw a question in stackoverflow with the magic words…

[https://stackoverflow.com/questions/76935210/extract-output-values-from-disk-image-file-as-strings-in-linux/76935417#76935417](https://stackoverflow.com/questions/76935210/extract-output-values-from-disk-image-file-as-strings-in-linux/76935417#76935417)

So I decided to help him and in the way, write this post

The problem
===========

> Get some words from specific lines of stdout string

This is very common in a devops daily job. You have to execute shell/bash commands and parse its result to have some valuable data.

Here the step by step solution, just for fun and learning. These commands will help you with your automation from simple bash scripts to platforms like [Jenkins](https://www.jenkins.io/)

Store the stdout in a variable
==============================

```
command_output=$(acme list)
```

This is the syntax to execute the command **acme list** and store all the stdout in the variable: **command_output**

The exception to this is the command fails. In that case you should use redirects:

*   [https://linuxize.com/post/bash-redirect-stderr-stdout/](https://linuxize.com/post/bash-redirect-stderr-stdout/)
*   [https://stackoverflow.com/questions/637827/redirect-stderr-and-stdout-in-bash](https://stackoverflow.com/questions/637827/redirect-stderr-and-stdout-in-bash)

Iterate line by line
====================

If we have a string variable **command_output**, you can iterate with this:

```
while read line  
    do echo ">>>>$line"   
done <<< "$command_output" 
```

At this point the variable **line** is ready to be **dissected**

If line starts with …
=====================

In this particular case, the requirement is to get lines starting with whit these words

*   Sector size
*   /home/documents/image-of-sd-card.img2

So, since I am a programmer (java, nodejs, php, python, c#), this is the classic **starts with feature.** With bash is:

```
if [[ "$line" == "Sector size"* ]]; then  
    echo ">>>>$line"   
elif [[ "$i" == "/home/documents/image-of-sd-card.img2"* ]]; then  
    echo ">>>>$line"       
fi
```

Split by one space
==================

This was hard to insert in my brain. Bash syntax is for martians (like me) so is very different of my beloved languages (java, nodejs). After hundred of automations, if the variable is **$line** the syntax to split by one space and get the 7 column is

```
echo "$line" | cut -d ' ' -f 7
```

Be careful if the line has more than one space. I researched and try martians workarounds and the result was: CUT don’t works for several spaces

Split by several spaces
=======================

Similar to the prior but with awk command. awk is so easy to learn. This is the syntax to split by several spaces and get the third column

```
echo "$line" | awk -F' ' '{ print $3 }'
```

All together
============

```
raw_content=$(cat input.txt) # change here wth your command  
  
sector_size=  
second_partition_size=  
  
echo  
  
while read line  
do   
  
    if [[ "$line" == "Sector size"* ]]; then  
        echo "Line found: $line"   
        sector_size=$(echo "$line" | cut -d ' ' -f 7)  
    elif [[ "$line" == "/home/documents/image-of-sd-card.img2"* ]]; then  
        echo "Line found: $line"   
        second_partition_size=$(echo "$line" | awk -F' ' '{ print $3 }')          
    fi  
  
done <<< "$raw_content"  
  
echo -e "\\nResults:"  
  
echo "sector_size: $sector_size"  
echo "second_partition_size: $second_partition_size"
```

and the output

Conclusion
==========

Iterate, split, starts with, store stdout in a var are the most basic commands in the linux word. Every devops automation professional should know them. They are easy, fast and funny.

Also, I advice you to know any language at most elementary level (junior developer) before start with bash. The translation of your high level language knowledge (java, python, nodejs, etc) to this beautiful low level command language: **Bash**
