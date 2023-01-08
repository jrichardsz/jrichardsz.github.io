---
layout: post
title: How to use complex health check in docker?
description: "I will show you how to use complex health checks validations in docker"
category: docker
tags: [docker]
comments: true
---

I will show you how to use complex check health validations in docke. 

The following post was my answer to https://stackoverflow.com/a/75044887/3957754

![](https://user-images.githubusercontent.com/3322836/211176324-2664c668-c613-4d1a-b067-95d4ff4b5a79.png)

image source: https://youtu.be/PSO_xKhSKEM

## Introduction

The validation of health of our services is a common practice and docker give us a feature for that.

Here an example of mysql health check

```yml
version: '3.7'

services:
  rosariosis_db:
    image: mysql:5.7
    container_name: rosariosis_db
    ports:
     - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: changeme
      MYSQL_USER: rosariosis_user
      MYSQL_PASSWORD: changeme
      MYSQL_DATABASE: rosariosis
      TZ: America/Lima
    networks:
      - rosariosis_network
    healthcheck:
      test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost"]
      timeout: 20s
      retries: 10
```      

Basically using bash commands, you could query to your service and if the result is an exit code with value 0, docker will flag your container as **healthy**. Any other value will cause that your container be flagged as **unhealthy**

## Approaches

Commonly I use the following tools or techniques to perform validations

### curl

```sh
test: curl --fail http://localhost || exit 1
```

### Search text in logs with GREP

```sh
test: 'cat /tmp/mysql-general-log.log | grep "root@localhost on  using Socket"'
```

### internal tool

```sh
test: [ "CMD", "redis-cli", "--raw", "incr", "ping" ]
```

## Complex validations with a script

For complex health check validations you should use a script in the test parameter of 
docker-compose.yml

```yml
version: '3.7'

services:
  rosariosis_db:
    image: mysql:5.7
    volumes:
     - ./healthcheck.sh:/tmp/healthcheck.sh
    healthcheck:
      test: 'bash /tmp/healthcheck.sh'
      timeout: 5s
      retries: 1
```

healthcheck.sh
```sh
#!/bin/bash
exit 0;
```

You could put any logic , just make sure to return `exit 0` for success and `exit 1` for error

```sh
#!/bin/bash

# https://superuser.com/a/442395
http_validation=$(curl -s -o /dev/null -w "%{http_code}" http://www.example.org)

if [[ $http_validation == 200 && $foo == "foo" ]]
then 
  exit 0 
else 
  exit 1
fi
```

## inline complex validation

According to [this](https://stackoverflow.com/a/46090275/3957754) you could use a complex conditional in the healthcheck:

```sh
test: ["CMD-SHELL", "if [ \"`echo \\\"SELECT ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME = 'ANONYMOUS' AND ACCOUNT_STATUS = 'EXPIRED';\\\"|/u01/app/oracle/product/12.1.0/xe/bin/sqlplus -S sys/oracle as sysdba|grep ACCOUNT_STATUS`\" = \"ACCOUNT_STATUS\" ];then true;else false;fi"]
```

### docker don't support $?

If docker health check supported `$?` we could use

```sh
mysqladmin ping -h localhost ; echo $? > /tmp/exit_1 ; mysqladmin ping -h localhost ; echo $? > /tmp/exit_2; [[ $(cat /tmp/exit_1) == 0 && $(cat /tmp/exit_2) == 0 ]]
```

Basically I store the exit status in a file and then I compare the values.

But since docker don't support that, I got this error:

```
Error: No such container: rosariosis_db
ERROR: Invalid interpolation format for "healthcheck" option in service "rosariosis_db": "mysqladmin ping -h localhost ; echo "$?""
```

## Lectures

- https://docs.docker.com/compose/compose-file/compose-file-v3/#healthcheck
- https://www.youtube.com/watch?v=PSO_xKhSKEM
- https://stackoverflow.com/questions/67904609/how-do-you-perform-a-healthcheck-in-the-redis-docker-image
- https://medium.com/geekculture/how-to-successfully-implement-a-healthcheck-in-docker-compose-efced60bc08e
- https://superuser.com/a/442395
- https://stackoverflow.com/a/46090275/3957754