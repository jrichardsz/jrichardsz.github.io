---
layout: post
title: How to deploy java application in a cloud instance from the scratch to an advanced architecture ?
description: "Deploy in compute engine instance of google not substantially different from AWS, Azure or another linux host provider"
category: devops
tags: [devops,jenkins,git,java,linux]
comments: true  
---

From a recent question in my favourite social network:

![https://raw.githubusercontent.com/jrichardsz/static_resources/master/stackoverflow.png](https://raw.githubusercontent.com/jrichardsz/static_resources/master/stackoverflow.png)

[https://stackoverflow.com/questions/53946704](https://stackoverflow.com/questions/53946704)

# How to deploy java application in a cloud instance from the scratch to and advanced architecture ?

Deploy in compute engine instance of google not substantially different from AWS, Azure or another linux host provider. 

You just need an ssh connection to the remote machine and install the required software to compile, build, zip, deploy, etc

I will list some approaches from basic(manually) or scratch to an advanced(automated):

# #1 Bash scripting

- unzip and configure git
- unzip and configure java
- unzip and configure maven
- unzip and configure tomcat (this is not required if spring-boot is used)
- configure the linux host to open 8080 port
- create a script called /devops/pipeline.sh 

For war deployment :

<b></b>

    # get the source code
    cd /tmp/folder/3dac58b7
    git clone http://github.com/myrepo.git .
    # create war
    mvn clean package
    # move war to deploy tomcat folder
    cp target/my_app.war /my/tomcat/webapps
    # stop tomcat
    bash /my/tomcat/shutdown.sh
    # start tomcat
    bash /my/tomcat/startup.sh

<b></b>

Or spring-boot startup

<b></b>

    # get the source code
    cd /tmp/folder/3dac58b7
    git clone http://github.com/myrepo.git .
    # create jar
    mvn clean package
    # kill or stop the application
    killall java
    # start the application
    java $JAVA_OPTS -jar $jar_file_name

<b></b>

- After push to git, just connect to you instance using ssh and execute

<b></b>

    bash /devops/pipeline.sh

Improvements: Parametrize repository name, branch name, mvn profile, database credentials, create a tmp/uuid folder in every execution, delete the tmp/uuid after deploy,optimize start and stop of application using pid, etc

# #2 Docker

- Install [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) in your instance
- Create a docker container with name **my-container-name** containing all the steps of approach #1 
- After push to git, just connect to you instance using ssh and execute:

<b></b>

    docker rm my_app -f
    docker run -d --name my_app -p 8080:8080 my-container-name

# #3 Artifact Repository (an extra instance is required)

- Configure [Nexus](https://www.sonatype.com/download-oss-sonatype) or [JFrog Artifactory](https://jfrog.com/open-source/#artifactory) in the new instance.

- Point your maven settings in  your development machine  to the url provided by the configured Artifact Repository.

- Modify the script of #1 or Dockerfile of #2 to :
  - avoid git installation
  - avoid git clone
  - avoid mvn clean package (This is not required any more because, the war file will be created in the development machine)
  - download war or jar file from [Artifact Repository](https://stackoverflow.com/a/1896110/3957754) 
- Use approaches #1 or #2

- When your are ready to deploy , push to git, and execute this in your development machine:

<b></b>

    # This will generate the war file and upload to the Artifact Repository.
    mvn clean install

# #4 Use a continuous integration server (an extra instance is required)

- Install Jenkins in the new instance
- Configure plugins and other required things in jenkins in order to enable **webhook url** : https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab
- Create a **job** in jenkins to call the script of approach #1 or execute docker commands of approach #2. If you can, Approach #3 would be perfect.
- Configure your SCM (github, bitbucket, gitlab, etc) to point to the **webhook url** published by Jenkins.

When you are ready to deploy, just push the code to your scm, jenkins will be notified and will execute the previous created job. As you can see, there is no human required to deploy de application in the server(With the exception of developer push)

# #5 Advanced (Sysadmin team or extra people and knowledge are required )

- Kubernetes
- Ansible
- High availability / Load balancer 
- Backups
- Configurations Management
- And more automations

This will be necessary when more and more web applications, microservices are required in your company/enterprise.

# #6 Saas

All the previous approaches could be **simplified** using WORLD CLASS platforms like:

- Jelastic
- Heroku
- Amazon Elastic Container Service
- Openshift, etc
