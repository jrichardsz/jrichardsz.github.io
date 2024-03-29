---
layout: post
title: Devops with Git and Jenkins using webhooks
description: "I show you the steps required to implement a basic devops routine using git webhooks and jenkins"
category: devops
tags: [jenkins,git, github, gitlab,bitbucket]
comments: true  
---

In this post I will show you how integrate git  and jenkins to make a basic devops routine using webhooks.

![home_page](https://raw.githubusercontent.com/jrichardsz/static_resources/master/easy-webhook-plugin.png)

# Requirement

- When I push to my git repository I need to launch  a jenkins job.

# Approach 01

Create a job in jenkins in which you must clone the git repository at regular intervals.


> This is simple but, hardware consumption is elevated and is a little **outdated**

<br><br>

# Approach 02

Using the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and some jenkins plugin related to your git repository provider ([github plugin](https://wiki.jenkins.io/display/JENKINS/GitHub+Plugin) , [bitbucket plugin](https://wiki.jenkins.io/display/JENKINS/Bitbucket+Plugin), [gitlab plugin](https://wiki.jenkins.io/display/JENKINS/GitLab+Plugin)) create a jenkins job to launch some tasks.

<br><br>

# Approach 03

Using the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and some jenkins plugin like   [https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin](https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin) create a jenkins job to launch some tasks( security configurations are required).

Read this post if you are interested in this plugin: https://jrichardsz.github.io/devops/jenkins-generic-webhook-trigger-plugin-for-devops-with-jenkins

<br><br>

# Approach 04

Use the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and this generic and easy jenkins plugin [https://github.com/utec/easy-webhook-plugin](https://github.com/utec/easy-webhook-plugin) ,  create a jenkins job to launch some tasks.


> In this post I will show you how implement this **approach 04** because is easy, ready to use and has a pre-configured steps to make life simpler.

<br><br>

# Proposed flow

![webhook-flow](https://raw.githubusercontent.com/jrichardsz/static_resources/master/jenkins/jenkins-webhook-flow.png)

- Developer push some source code (java, php, nodejs, etc)
- Your git platform (bitbucket, gitlab, github, etc) detects this event and perform an http post request to your webhook url (preconfigured in github and jenkins) sending it a json payload with important information related to detected event.
- Jenkins receive the http post request and using the easy-webhook-plugin
, will parse the json payload and extract some important or common values used in devops automation like : branch name, commit author, commit message, etc
- Jenkins launch a preconfigured job. In this job you could extract use the previously extracted values like branch name. At this point you could start, launch or invoke any technology. (tomcat and postgress in flow image)

# Previous knowledge

- Webhook

  First, what is a webhook? The concept of a webhook is simple. A webhook is an HTTP callback, an HTTP POST that occurs when something happens through a simple event-notification via HTTP POST.

  For instance, GitHub webhooks in Jenkins are used to trigger the build whenever a developer commits something to the master branch.

  In the proposed flow, We can appreciate an arrow from github to jenkins called **webhook**. This represent a json sent from github to jenkins. We will call **webhook_json** to this json. In this json, github send us data like :
    - git repository name
    - branch which was changed
    - commit id
    - commit message
    - commit author
    - etc

  This is an example of webhook json sent by github when a push is performed : [https://gist.github.com/jrichardsz/3ded3cb429d51cc826373e8bded15a8f](https://gist.github.com/jrichardsz/3ded3cb429d51cc826373e8bded15a8f)  

- JSONPath specification

  - Understand this specification that allow us lookup values from complicated json nodes in a easy way.
  - [http://jsonpath.com/](http://jsonpath.com/)  
  - [http://goessner.net/articles/JsonPath/](http://goessner.net/articles/JsonPath/)
  - This will help us to extract values from our **webhook_json**


# Prerequisites

- Jenkins Server

  - We need an instance ready to use of the latest version of this CI Server.
  - This is the common way to install jenkins on linux: [https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-16-04)
  - Openshift is a easy and fast way to get an online jenkins server.

- Git repository

  - We need some git repository without errors and ready to build. For this post we will use a public github repository to avoid authentication configurations like : ssh-agent, ssh keys, etc.
  - In subsequent posts I will show the exact steps to do this.

# Steps

1. Configure required plugins in jenkins.
2. Create a jenkins job which will be triggered by our git provider (gitlab in this example).
3. Get the **webhook url**
4. Test with curl
5. Configure the **webhook url** in your git provider (gitlab in this example).
6. Git push using some git platform : github, bitbucket or gitlab (this example)

<br>
<img src="https://raw.githubusercontent.com/jrichardsz/static_resources/master/meme/meme-lets-start.jpg" width="300" style="display:  block;margin-left:  auto;margin-right: auto;">
<br>

<br><br>
# (01) Configure required plugins in jenkins.

Install this pluging in jenkins server:

- [Locale Plugin](https://wiki.jenkins.io/display/JENKINS/Locale+Plugin)
  - In order to change languaje to english because 90% of errors, issues and documentation are in english.

- [Pipeline Plugin](https://jenkins.io/doc/book/pipeline/)
  - In order to create our workflows as [pipelines](https://www.sumologic.com/devops/understand-build-continuous-delivery-pipeline/) (build -> test -> sonar -> deploy -> etc) programmatically with groovy.

- [Easy Webhook Plugin](https://github.com/utec/easy-webhook-plugin)  
   In order to expose a public endpoint to triggering a jenkins job. Follow these instructions to install and configure this plugin:
    - https://github.com/utec/easy-webhook-plugin#plugin-installation
    - https://github.com/utec/easy-webhook-plugin#plugin-configuration


<br><br>

# (02) Create a jenkins job

- In jenkins home page click en new item and select "pipeline", enter an item name and click in ok:

    ![jenkins-new-item-pipeline.png](https://www.baeldung.com/wp-content/uploads/2017/12/jenkins3.png)

- Parameters are nor required. Plugin will inject them

- In **pipeline section** , choose Pipeline Script

    ![jenkins-pipeline-input-box.png]({{ site.url }}/images/jenkins-pipeline-input-box.png)

  And add the following script into the text area:

<script src="https://gist.github.com/jrichardsz/a62e3790c6db7654808528bd5e5a385f#file-jenkins_scripted_pipeline_print_params-js"></script>

- Save job configuration.

<br><br>

# (03) Get the webhook url

After configure the easy webhook plugin, a new http url will be ready to use as webhook url.

After a success installation and configuration you could have this scenario :

| Parameter        | Description  | Example  |
|:------------- |:-----|:----
| jenkins host      | ip or public domain |  my_jenkins.com or localhost:8080
| easy webhook secret key      | plugin configuration | 123456789
| scmId      | one of the well known scm: gitlab, bitbucket or github | gitlab
| jobId      | name of any existent jenkins job | hello_word_job


With the previous parameters, your webhook url will be:

http://my_jenkins.com/easy-webhook-plugin-123456789/?scmId=gitlab&jobId=hello_word_job

<br><br>
# (04) Test with curl

In order to test this plugin, we will simulate a gitlab push event using curl.

For this test, we need a **exact** gitlab webhook json sample. Here an [example](https://gist.github.com/jrichardsz/3d55df91181e3fb83089d08ada6809a8)

Download this json and save in some file like: /tmp/gitlab_webhook.json

I everything is good, you can exec this curl:

```
curl -d @/tmp/gitlab_webhook.json \
-H "Content-Type: application/json" \
-X POST "http://my_jenkins.com/easy-webhook-plugin-123456789/?scmId=gitlab&jobId=hello_word_job"
```

If you go to your jenkins home, you must see a new build execution in your **hello_word_job** job

<br><br>
# (05) Configure the **webhook url** in your git provider

Follow this post to add this url as webhook in your git repository provider : [https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab](https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab)

<br><br>
# (06) Git push

If the previous test with curl worked, your webhook is ready to use :D with any git platform (gitlab for example).

Create some git repository and add the following url as webhook for **push** events. Check this [post](https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab) to get a detailed guide for bitbucket, github and gitlab.

The url to register will be something like this:

  `
http://my_jenkins.com/easy-webhook-plugin-123456789/?scmId=gitlab&jobId=hello_word_job
  `
Or if you want, add new http query parameter like **notificationUsers**

  `
http://my_jenkins.com/easy-webhook-plugin-123456789/?scmId=gitlab&jobId=hello_word_job&notificationUsers=jane.doe@blindspot.com
  `

Finally, just **git push** some change and go to your Jenkins to see the new build in progress :D
