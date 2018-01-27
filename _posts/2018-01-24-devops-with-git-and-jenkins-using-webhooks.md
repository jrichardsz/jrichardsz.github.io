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

# Goals

- When I push to my git repository I need to launch  a jenkins job.
- This Jenkins job must be access to some variables from webhook post in order to build my app, like
  - repository git url
  - pushed branch

# GIT

This topic is easy. We need some repository without errors and ready to build. For this post we will use a public github repository to avoid authentication configurations like : ssh-agent, ssh keys, etc. In subsequent posts I will show the exact steps to do this.

# Jenkins

We need the latest version of this CI Server.

This is the common way to install jenkins on linux: [https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)

# Requirements

- Jenkins instance ready to use.

- [Locale Plugin](https://wiki.jenkins.io/display/JENKINS/Locale+Plugin)
  - In order to change languaje to english because 90% of errors, issues and documentation are in english.

- [Generic Webhook Trigger Plugin](https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin)  
   In order to expose a public endpoint to triggering the jenkins job

- [Pipeline Plugin](https://jenkins.io/doc/book/pipeline/)
  - In order to create our workflows as [pipelines](https://www.sumologic.com/devops/understand-build-continuous-delivery-pipeline/) (build -> test -> sonar -> deploy -> etc) programmatically with groovy.

- Jenkins user and password.
  - To use as basic authentication in url

- Jsonpath : [http://jsonpath.com/](http://jsonpath.com/)
  - To extract some values from json sent by git provider.
  - We assume that this is the json :

  ```
  {
    "webhook_var": "hello jenkins",
    "other_var": "other_value"
  }
  ```
<br>
<img src="https://memegenerator.net/img/instances/500x/72913234/lets-begin.jpg" width="300" style="display:  block;margin-left:  auto;margin-right: auto;">
<br>

# Jenkins configuration

- In jenkins home page click en new item and select "pipeline" and enter an item name:

    ![jenkins-new-item-pipeline.png]({{ site.url }}/images/jenkins-new-item-pipeline.png)

- In *build trigger* section choose : Generic Webhook Trigger

    - In variable input write : **webhook_var** (variable which will be extracted from json)
    - In Expression input write : **$.webhook_var**. This is the jsonpath expression to extrac webhook_var value from json string.
    - And check : **JSONPath**

- In pipeline section , choose Pipeline Script

    ![jenkins-pipeline-input-box.png]({{ site.url }}/images/jenkins-pipeline-input-box.png)

  And in the input :

```
  node {
      stage ('read post var from webhook') {
         echo 'Hello World webhook'
         echo 'webhook_var :' + webhook_var
      }
  }
```

  In this line *echo 'webhook_var :' + webhook_var* whre are using **webhook_var** var extracted from json using jsonpath

- Save job configuration.

This configuration enable an url ready to configure in some git provider :

```
http://JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke
```

But if you test this url, jenkins shows you an error related to authentication, that is why we need some user and password to make a basic authentication in url:

```
http://some_user:some_password@JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke
```

# Execute jenkins job from commandline

When webhook is configured in your git repository, this will post to your public endpoint with a json contains information about git event. For example : user who commit, branch pushed, git url to clone, commit, message, etc. This json is different in github, bitbucket, gitlab, etc

In order to test this job or simulate some git event, wen will use **curl** command to send a simple json to our job:

```
curl -X POST -H "Content-Type: application/json" \
-d '{ "webhook_var": "hello jenkins", "other_var": "other_value" }' \
-vs http://some_user:some_password@JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke
```
 If no errors, you will see a success response in commanline and in your jenkins you will see a job execution:

 ![jenkins-pipeline-input-box.png]({{ site.url }}/images/job_history.png)

Click in job console of this execution and you will see :

 ![jenkins-pipeline-input-box.png]({{ site.url }}/images/job_webhook_console.png)

This will confirm that you have a jenkins job ready to receive post from everywhere like bitbucket, github, gitlab, etc

# Configure Bitbucket webhook

Now we must add this url as webhook endpoint in our git provider: http://JENKINS_HOST:JENKINS_PORT/generic-webhook-trigger/invoke

- Bitbucket
  ![https://blog.bitbucket.org/files/2015/06/webhooks.jpg](https://blog.bitbucket.org/files/2015/06/webhooks.jpg)

- Github
 ![jenkins-pipeline-input-box.png]({{ site.url }}/images/github_webhook.png)

- Gitlab
![https://about.gitlab.com/images/blogimages/continuous-delivery-with-gitlab-and-convox/gitlab-webhooks.png](https://about.gitlab.com/images/blogimages/continuous-delivery-with-gitlab-and-convox/gitlab-webhooks.png)

# Push and triggering webhooks

After all steps, you just need push some change to your git repository and , this git provider will be execute the url published by jenkins, and jenkins job will be launched.

But beware that each one of git providers , send a different json to jenkins. So you need to create a custom jsonpath expression depends of your git provider.

# Coming soon

- Configure authentication for git
- Configure user and roles in jenkins
- Using token instead of user:password in generic webhook url published by jenkins
- Show webhooks configuration for all providers : gitlab, github, bitbucket
