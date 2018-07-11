---
layout: post
title: Devops with Git and Jenkins using webhooks
description: "I show you the steps required to implement a basic devops routine using git webhooks and jenkins"
category: devops
tags: [devops,jenkins,git, github, gitlab,bitbucket]
comments: true  
---

In this post I will show you how integrate git  and jenkins to make a basic devops routine using webhooks.

![https://www.fourkitchens.com/wp-content/uploads/2017/01/Jenkins_git_0.png](https://www.fourkitchens.com/wp-content/uploads/2017/01/Jenkins_git_0.png)

# Requirement

- When I push to my git repository I need to launch  a jenkins job.

# Approach 01

- Create a job in jenkins in which you must clone the git repository at regular intervals. 

> This is simple but, hardware consumption is elevated and is a little **outdated**

# Approach 02

- Use the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and some configurations in our Jenkins platform.
- This is the proposed flow :

![webhook-flow](https://raw.githubusercontent.com/airavata-courses/TeamAlpha/master/Airavata_Remote_Job_Runner/Instructions/Jenkins.png)

- Instead of tomcat and postgress you could use any technology.
- In the arrow from github to jenkins we appreciate a string **webhook**. This represent a json sent from github to jenkins. We will call **webhook_json** to this json. In this json, github send us data like :
  - git repository name
  - branch which was changed
  - commit id
  - commit message
  - commit author
  - etc
- This is an example of webhook json sent by github when a push is performed : [https://gist.github.com/jrichardsz/3ded3cb429d51cc826373e8bded15a8f](https://gist.github.com/jrichardsz/3ded3cb429d51cc826373e8bded15a8f)  

> In this post I will show you how implement this **approach 02**.


# Prerequisites

- Jenkins Server

  - We need an instance ready to use of the latest version of this CI Server. 
  - This is the common way to install jenkins on linux: [https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)
  - Openshift is a easy and fast way to get an online jenkins server.

- Git repository

  - We need some repository without errors and ready to build. For this post we will use a public github repository to avoid authentication configurations like : ssh-agent, ssh keys, etc. 
  - In subsequent posts I will show the exact steps to do this.
  
- JSONPath specification
  - Understand this specification that allow us lookup values from complicated json nodes in a easy way.
  - [http://jsonpath.com/](http://jsonpath.com/)  
  - [http://goessner.net/articles/JsonPath/](http://goessner.net/articles/JsonPath/)
  - This will help us to extract values from our **webhook_json**

# Steps

1. Configure required plugins in jenkins.
2. Jenkins user and password.
3. Create a jenkins job which will be triggered by our git provider (github in this case). This job publish an http url ready to use. We will call **webhook_url** to this url.
4. Configure **webhook_url** in webhook section of github of some repository.
5. Test this flow, pushing some change to our git repository or simulating it using commandline.

<br>
<img src="https://memegenerator.net/img/instances/500x/72913234/lets-begin.jpg" width="300" style="display:  block;margin-left:  auto;margin-right: auto;">
<br>

# (01) Configure required plugins in jenkins.

Install this pluging in jenkins server:

- [Locale Plugin](https://wiki.jenkins.io/display/JENKINS/Locale+Plugin)
  - In order to change languaje to english because 90% of errors, issues and documentation are in english.

- [Generic Webhook Trigger Plugin](https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin)  
   In order to expose a public endpoint to triggering the jenkins job

- [Pipeline Plugin](https://jenkins.io/doc/book/pipeline/)
  - In order to create our workflows as [pipelines](https://www.sumologic.com/devops/understand-build-continuous-delivery-pipeline/) (build -> test -> sonar -> deploy -> etc) programmatically with groovy.

# (02) Jenkins user and password.

To use as basic authentication in url, we need some user created in jenkins server. Just create one user or use your admin user only for test.

In subsequent posts I show my plugin which does not need authentication.

# (03) Create a jenkins job

- In jenkins home page click en new item and select "pipeline" and enter an item name:

    ![jenkins-new-item-pipeline.png]({{ site.url }}/images/jenkins-new-item-pipeline.png)

- In *build trigger* section choose : Generic Webhook Trigger

This plugin allow us to extract values from **webhook_json** using **jsonpath**

According to a section of entire **webhook_json** :
        
<script src="https://gist.github.com/jrichardsz/828ff5f27aa06bbd2883be885fc0dd8e.js"></script>  
  
  - If we want to extract repository name and commit author we need to use this jsonpath expressions : **$.repository.name** and **$.pusher.name**
  - To do thath, in variable input write : **repository_name** (variable which will be extracted from json)
  - In Expression input write : **$.repository.name**. 
  - And check : **JSONPath**
  - Do the same for **commit_author** variable name and **$.pusher.name** jsonpath expression.
  - From this point, you can use **repository_name** and **commit_author** as variables in anyh part of this jenkins job.

- In **pipeline section** , choose Pipeline Script

    ![jenkins-pipeline-input-box.png]({{ site.url }}/images/jenkins-pipeline-input-box.png)

  And in the input put this lines:

<script src="https://gist.github.com/jrichardsz/ae0f32b1fd695b3647ff159b46ae6751.js"></script>

- Save job configuration.

This configuration enable an url ready to configure in some git provider :

```
http://JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke
```

But if you test this url, jenkins shows you an error related to authentication, that is why we need some user and password to make a basic authentication in url:

```
http://some_user:some_password@JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke
```

The previous url is ready to use in webhook configuration whether bitbucket, gitlab or github (this example)

# (04) Configure Bitbucket webhook

Now we must add this url as webhook endpoint in our git provider. Also select push event and json. This is similar in github, bitbucket or gitlab:

- http://JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke

- Bitbucket
  ![bitbucket-webhook-configuration.png]({{ site.url }}/images/webhooks-bitbucket.jpg)

- Github
 ![github-webhook-configuration.png]({{ site.url }}/images/github-webhook-configuration.png)

- Gitlab
 ![gitlab-webhook-configuration.png]({{ site.url }}/images/gitlab-webhooks.png)

# (05) Test this flow 

- Pushing to github

After all steps, you just need push some change to your git repository and , this git provider will be execute the url published by jenkins, and jenkins job will be launched.

But beware that each one of git providers , send a different json to jenkins. So you need to create a custom jsonpath expression depends of your git provider.

- With command line

When webhook is configured in your git repository, this will post to your public endpoint with a json contains information about git event. For example : user who commit, branch pushed, git url to clone, commit, message, etc. This json is different in github, bitbucket, gitlab, etc

In order to test this job or simulate some git event, wen will use **curl** command to send a simple json to our job:

<script src="https://gist.github.com/jrichardsz/71249d4d5531060aca924cf3cf0dbceb.js"></script>

- Verify on jenkins server

 If no errors, you will see a success response in commanline and in your jenkins you will see a job execution:

 ![jenkins-pipeline-input-box.png]({{ site.url }}/images/job_history.png)

Click in job console of this execution and you will see :

 ![jenkins-pipeline-input-box.png]({{ site.url }}/images/job_webhook_console.png)

This will confirm that you have a jenkins job ready to receive post from everywhere like bitbucket, github, gitlab, etc


# Coming soon

- Configure authentication for git
- Configure user and roles in jenkins
- Using token instead of user:password in generic webhook url published by jenkins
- Show webhooks configuration for all providers : gitlab, github, bitbucket
- I will develop a simple plugin to make life easier. This plugin will be called : **easy webhook plugin**