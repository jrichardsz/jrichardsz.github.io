---
layout: post
title: Configure webhooks in github, bitbucket and gitlab
description: "In this post I will show you how to configure a webhook."
category: devops
tags: [devops, webhook, git, github, gitlab, bitbucket]
comments: true  
---

In this post I will show you how to configure a webhook in the most used git repository providers.

![github-bitbucket-gitlab](https://image.slidesharecdn.com/introduction-to-gitea-170422142210/95/a-painless-selfhosted-git-service-gitea-5-638.jpg)

# Prerequisites

- Public http url, able to receive POST request with json body. This url could be a simple http app with nodejs, ruby, java, php or something advanced like jenkins, travis, etc

# Steps 

We just need to add the public url in **webhook** section and select some event like git push. This is similar in github, bitbucket or gitlab

# Bitbucket

![bitbucket-webhook-configuration.png]({{ site.url }}/images/webhooks-bitbucket.jpg)

# Github

![github-webhook-configuration.png]({{ site.url }}/images/github-webhook-configuration.png)

# Gitlab

![gitlab-webhook-configuration.png]({{ site.url }}/images/gitlab-webhooks.png)

> Thats all!! Your git repository provider is ready to send webhook payloads to your public url.
