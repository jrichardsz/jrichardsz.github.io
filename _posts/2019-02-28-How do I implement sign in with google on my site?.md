---
layout: post
title: How to deploy java application in a cloud instance from the scratch to an advanced architecture ?
description: "Deploy in compute engine instance of google not substantially different from AWS, Azure or another linux host provider"
category: devops
tags: [devops,jenkins,git,java,linux]
comments: true  
---

Imagine that we are working for an startup called www.aincrad.com and we need:

> Allow to the user , start session in the web using some social network like facebook, instagram or application like gmail, paypal, etc

In this post I will show you the common steps to accomplish this requirement.

# Web console configuration

For this post, we will imagine a social network or widely used application called : Sword Art Online with a domain www.swordartonline.com

This application has a login in which users enter the classic username and password. So our startup www.aincrad.com needs to use the login of www.swordartonline.com


If this application www.swordartonline.com is decent, must have a **web console** or **developer portal** to allow advanced configurations. Here some web consoles as example:

- https://developers.facebook.com/
- https://console.cloud.google.com/

Common steps in this web console could be:

- Create an application called : aincrad
- Configure an image and title
- Enter the origin domain :   www.aincrad.com
- Enter the callback url:  www.aincrad.com/mycallback

After this configuration you will be prompted with a kind of credentials. For google is clientId and clientSecret.


# Redirect

If www.aincrad.com needs to use the login of www.swordartonline.com, these could be the steps:

- When user enter to www.aincrad.com we need to validate if a session variable called **userInformation** exist. If not exist, this means that this user does not have a started session in the platform.
- If **userInformation** is empty or null, you need to redirect the user to www.swordartonline.com login. To do this, you can perform an http request to some public endpoint published by www.swordartonline.com using the credentials of previous step. This endpoint will return an url somethins like: www.swordartonline.com/oauth/authorize/...
- This url will prompt to our user with www.swordartonline.com login and after username/password a message  like : **www.aincrad.com would like permission to access to your account ...** will be prompted to the user.
- If user accepts, www.swordartonline.com will redirect to source application using the **callback** configured in the web console, adding an important get parameter called **code**. In our case is www.aincrad.com/mycallback?code=AUTHORIZATION_CODE

# /mycallback

This url or endpoint www.aincrad.com/mycallback:

- Must be **public** to allow execution from www.swordartonline.com.
- Must allow the receipt of get parameter called code.

Commonly this endpoint is developed using the same backend technology of your web like : java, ruby, php, node.js etc.

At this point if you are able to get the value of parameter called **code** in the  backend controller of www.aincrad.com/mycallback, it will indicate that the user has successfully logged in www.swordartonline.com. So you can save or persist a variable called **userInformation** in the session to avoid all these steps if user enter again to the web. If user logout, you must clear or delete this value.

# Get user email

If you need an extra level of validation, you could perform a new http request to some api like www.swordartonline.api.com/user. To do that you need to send the **code** to another www.swordartonline.com endpoint in order to get the **access_token**, something like:

https://swordartonline.com/v1/oauth/token?client_id=CLIENT_ID&client_secret=CLIENT_SECRET&grant_type=authorization_code&code=AUTHORIZATION_CODE&...

Finally perform an http request to www.swordartonline.api.com/user sending the access_token as header. If the response contains a json with user information, it will indicate that the user has successfully logged in www.swordartonline.com
