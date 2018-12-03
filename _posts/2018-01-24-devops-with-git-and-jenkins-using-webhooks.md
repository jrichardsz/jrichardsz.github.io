---
layout: post
title: Devops with Git and Jenkins using webhooks
description: "I show you the steps required to implement a basic devops routine using git webhooks and jenkins"
category: devops
tags: [devops,jenkins,git, github, gitlab,bitbucket]
comments: true  
---

In this post I will show you how integrate git  and jenkins to make a basic devops routine using webhooks.

![home_page](https://raw.githubusercontent.com/jrichardsz/static_resources/master/easy-webhook-plugin.png)

# Requirement

- When I push to my git repository I need to launch  a jenkins job.

# Approach 01

- Create a job in jenkins in which you must clone the git repository at regular intervals. 


> This is simple but, hardware consumption is elevated and is a little **outdated**


# Approach 02

- Using the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and some jenkins plugin related to your git repository provider ([github plugin](https://wiki.jenkins.io/display/JENKINS/GitHub+Plugin) , [bitbucket plugin](https://wiki.jenkins.io/display/JENKINS/Bitbucket+Plugin), [gitlab plugin](https://wiki.jenkins.io/display/JENKINS/GitLab+Plugin)) create a jenkins job to launch some tasks.

# Approach 03

- Using the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and some jenkins plugin like   [https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin](https://wiki.jenkins.io/display/JENKINS/Generic+Webhook+Trigger+Plugin) create a jenkins job to launch some tasks( security configurations are required).

Read this post if you are interested in this plugin: https://jrichardsz.github.io/devops/jenkins-generic-webhook-trigger-plugin-for-devops-with-jenkins

# Approach 04

- Use the latest functionality provided by github, gitlab, bitbucket, etc called : **webhooks** and this generic and easy jenkins plugin [https://github.com/utec/easy-webhook-plugin](https://github.com/utec/easy-webhook-plugin) ,  create a jenkins job to launch some tasks.


> In this post I will show you how implement this **approach 04** because is easy, ready to use and has a pre-configured steps to make life simpler.


# Proposed flow

![webhook-flow](https://raw.githubusercontent.com/airavata-courses/TeamAlpha/master/Airavata_Remote_Job_Runner/Instructions/Jenkins.png)

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

- [Easy Webhook Plugin](https://github.com/utec/easy-webhook-plugin)  
   In order to expose a public endpoint to triggering a jenkins job. Follow this instructions : https://github.com/utec/easy-webhook-plugin#usage

- [Pipeline Plugin](https://jenkins.io/doc/book/pipeline/)
  - In order to create our workflows as [pipelines](https://www.sumologic.com/devops/understand-build-continuous-delivery-pipeline/) (build -> test -> sonar -> deploy -> etc) programmatically with groovy.

# (02) Create a jenkins job

- In jenkins home page click en new item and select "pipeline", enter an item name and click in ok:

    ![jenkins-new-item-pipeline.png](https://www.baeldung.com/wp-content/uploads/2017/12/jenkins3.png)

- Add parameters using **This project is parameterized** option:
  - string parameter : repositoryName
  - string parameter : branchName

- In **pipeline section** , choose Pipeline Script

    ![jenkins-pipeline-input-box.png]({{ site.url }}/images/jenkins-pipeline-input-box.png)

  And add the following script into the text area:

<script src="https://gist.github.com/jrichardsz/a62e3790c6db7654808528bd5e5a385f.js"></script>

- Save job configuration.

# (03) Configure Bitbucket webhook

After configure the easy webhook plugin (https://github.com/utec/easy-webhook-plugin#usage), a new http url will be ready to use as webhook url. 

For instance, if you have this scenario :

- jenkins public domain : http://my_jenkins.com
- jenkins job : my_awessome_jenkins_job
- easy webhook key : 123456789
- git repository provider : bitbucket

Your webhook url will be:

http://my_jenkins.com/easy-webhook-plugin_123456789/?gitRepositoryManagementId=bitbucket&jobId=my_awesome_jenkins_job

Follow this post to add this url as webhook in your git repository provider : [https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab](https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab)

# (04) Test

- Pushing to github

  After all steps, you just need push some change to your git repository and , this git provider will be execute the url published by jenkins, and jenkins job will be launched.

  But beware that each one of git providers , send a different json to jenkins. **Easy Webhook Plugin** helps for bitbucket, github and gitlab. If you are using other git repository platform, you must to create a custom jsonpath expression in global plugin configuration.

- With command line

  In order to test this flow simulating some git event, We will use **curl** command to send a simple json to our job:

  <script src="https://gist.github.com/jrichardsz/af8321b413e0c37028197046c407e10a.js"></script>
  
  **webhook_payload.json** must be a correct json. You could use :
  
    - [webhook json from github](https://gist.github.com/jrichardsz/d8017ec4195dd3cd51a5e4fc8ce9eb3e#file-github_json_webhook_payload-json)
    - [webhook json from bitbucket](https://gist.github.com/jrichardsz/52edc692ea6876f6409f93d1d2b1e175#file-bitbucket_json_webhook_push_payload-json)

- Verify jenkins job execution

  If everything is well,you will see a job execution in your jenkins:

  ![jenkins-pipeline-input-box.png]({{ site.url }}/images/job_history.png)

  Click in job console of this execution and you will see :

  ![jenkins-pipeline-input-box.png](https://raw.githubusercontent.com/jrichardsz/static_resources/master/jenkins_build_easy_webhook_plugin.png)

This will confirm that you have a jenkins job ready to receive post from everywhere like bitbucket, github, gitlab, etc
