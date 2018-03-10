---
layout: post
title: stdout and stderr in devops
description: "In devops sometimes stdout saves the presidents life!"
category: java
tags: [devops, bash, shell]
comments: true  
---

# Exit status

Check this post to learn about **exit status** :

[https://jrichardsz.github.io/linux/exit-status-of-a-command](https://jrichardsz.github.io/linux/exit-status-of-a-command)

# sdout stderr

This is well known as standard output. Do you remember this in c++ ? :

```
cout >> "Hello worl c++";
```

Or in java :

```
System.out.println("Hello world java");
```

So if you create some awesome tool and use this sentences, when a client uses it, his console will show your "Hello world ..."

# Thank you so much for existing

When you develop some devops scripts , stdout is almost a pain in my &%&%%$#$%# because screen console is **contaminated** with uncontrolled messages.

But some times, stdout helps for example with sqlplus tool.

**sqplus** does not return a nonzero value for errors. So the only way to detect if a command was successful  is to interpret stdout message.

For example:

```
sqlplus user/password@sid < sqlfile.sql
```

In case of some error , return :

```
ERROR at line 1:
ORA-01403: no data found
ORA-06512: at "TAROT.TEST_PROC", line 4
ORA-06512: at line 1
```

But **$?** exit status is zero, so we can't use exit status to detect success or failure for this tool.


# Parsing stdout message

Given the last case, this script could help you to detect success or error :

Get message as var:

```
sqlplus_message=$(sqlplus user/password@sid < sqlfile.sql)
```

Check for **ERROR** string in **sqlplus_message**

```
if [[ $sqlplus_message == *"ERROR"* ]]; then
  echo "success"
else
  echo "success"
fi

```

# Disable stdout and stderr

In many cases, stdout must be disabled to ensure a clean console messages.

For example, this script:

```
mvn_detect() {
  maven_version=$(mvn -v)
  status=$?
  echo $status
}

echo "status:$(mvn_detect)"
```

return  :

```
mvm.sh: line 2: mvn: command not found
status:127
```

This line is not required : **mvm.sh: line 2: mvn: command not found**. I don't review linux code but I think that this is a kind of stdout, so for disabled it I used:


**> /dev/null 2>&1**


```
mvn_detect() {
  maven_version=$(mvn -v > /dev/null 2>&1)
  status=$?
  echo $status
}
echo "status:$(mvn_detect)"
```

and the result was clean:

```
status:127
```

That's it for today.
