---
layout: post
title: Devops with Bitbucket and Jenkins
description: "I show you the steps required to implement a basic devops routine using bitbucket webhooks and jenkins"
category: devops
tags: [devops,jenkins,bitbucket]
comments: true  
---

In this post I will show you how integrate bitbucket and jenkins to make a basic devops routine.

![http://blog.flagbit.de/wp-content/uploads/2016/01/bitbucket_jenkins.png](http://blog.flagbit.de/wp-content/uploads/2016/01/bitbucket_jenkins.png)

# Requirements

- When I push to my bitbucket repository I need to launch  a jenkins job.
- This Jenkins job must be access to some variables in order to build my app
  - repository git url
  - pushed branch

# Bitbucket

This topic is easy. We need some repository without errors and ready to build. For this post we will use a public bitbucket repository to avoid authentication configurations like : ssh-agent, ssh keys, etc. In subsequent posts I will show the exact steps to do this.

# Jenkins

We need the latest version of this CI Server.

This is the common way to install jenkins on linux: [https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)

After that, this are the required plugins:

- [Locale Plugin](https://wiki.jenkins.io/display/JENKINS/Locale+Plugin)
  - In order to change languaje to english because 90% of errors, issues and documentation are in english.

- [Generic Webhook Trigger Plugin](https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin)  
   In order to expose a public endpoint to triggering the jenkins job

- [Pipeline Plugin](https://jenkins.io/doc/book/pipeline/)
  - In order to create our workflows as [pipelines](https://www.sumologic.com/devops/understand-build-continuous-delivery-pipeline/) (build -> test -> sonar -> deploy -> etc) programmatically with groovy.

Install it!!

# Let us go to work!!!

## Jenkins job as webhook receiver

- In jenkins home page click en new item and select "pipeline" and enter an item name:

    ![jenkins-new-item-pipeline.png]({{ site.url }}/images/jenkins-new-item-pipeline.png)

- In pipeline section , choose Pipeline Script

    ![jenkins-pipeline-input-box.png]({{ site.url }}/images/jenkins-pipeline-input-box.png)

  And in the box put :

  [https://github.com/jenkinsci/generic-webhook-trigger-plugin/blob/master/sandbox/multibranch.jenkinsfile](https://github.com/jenkinsci/generic-webhook-trigger-plugin/blob/master/sandbox/multibranch.jenkinsfile)
