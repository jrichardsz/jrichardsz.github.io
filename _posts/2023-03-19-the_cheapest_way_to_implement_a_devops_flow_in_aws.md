---
layout: post
title: The cheapest way to implement a devops flow in AWS
description: ""
category: devops
tags: [aws, webhook, git, docker]
comments: true
---

<img src="https://user-images.githubusercontent.com/3322836/226238044-0dca953a-6f9a-4e06-96b5-2c984ee6d6bc.png" width=500>

After having implemented devops in a several cloud platforms like gcp, azure, aws, heroku, buddy.works, huawei, etc with several tools like jenkins, kubernetes, travis, bamboo, gitlab-ci, etc, there are in my mind many ways to implement a devops flows from the scratch to ready to use platforms, from manual to automated and from cheapest to more expensive.

In this post I will show you how to implement the cheapest devops flow for **startups, pocs, or very limited production environments.**

## Not for enterprises

If you are part of an enterprise with real users, employees, etc which earns money **you should invest in your digital infrastructure** if you want to guarantee a good user experience or don't lose to the competition.

If you are the CEO, CTO, etc but don't have any knowledge about software engineering, **please hire someone who knows**.

If you opt to save money in this department, you will regret it and you could lose a lot of money because of it.

## What is the most expensive in aws?

The most expensive is the hard drive or storage (Elastic block store EBS) and how many hours is the cloud resource (Amazon Elastic Compute Cloud) online. Everything is billed hourly.

## Most basic devops flow

In this example, we will not have testing environment. Just on: Production

<img src="https://www.planttext.com/api/plantuml/png/LOv12iCm30JlUiMIUxvGyfFYrgejKErWhm_zVKdIG7eHcjr1QEaCZUFjuleYMD4iPI9QqoUj5f5j2IMv8XdlRfrQj25qJ0U0UU-mZfwdY_yOvl72KLUl7v6_Ey0yttxgFe_WT6NH4hV_lW00" width=500>

## Listen the git push

In a real enterprises, they have a 24*7 server called "Continuous Integration Server" which is responsible to listen the git push from github, gitlab, bitbucket, etc. 

Here an example with Jenkins: https://jrichardsz.github.io/devops/devops-with-git-and-jenkins-using-webhooks

To listen the git push, the git platform provider (github, gitlab, bitbucket, etc) sends a huge json to an http url (configured previously). The json contains a lot of information about the git event: repository name, target branch, commit message, commit, author, etc

That feature is called Webhooks. Check this https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab to understand how to configure the webhook.

**To save money on this** we will use Aws Lambdas which only charges us for the time it takes to execute the function

## Aws Lambda with nodejs

This is the serverless feature of aws. Basically is just a function on several languages which are triggered from several sources.

<img src="https://user-images.githubusercontent.com/3322836/226233841-992a9d4b-27a3-4988-90d5-e1fc33b21c4d.png" width=500>

We will execute this function on every git push using the webhook feature which required a public http url (if you understood what a webhook is). 

According to this https://docs.aws.amazon.com/lambda/latest/dg/urls-invocation.html , every lambda function could be executed invoking its http url:

```
curl -v -X POST \
      'https://abcdefg.lambda-url.us-east-1.on.aws/?message=HelloWorld' \
      -H 'content-type: application/json' \
      -d '{ "example": "test" }'
```

And the incoming body could be read inside the lambda function like this:

```
exports.handler = function(event, context, callback) {
  const body = JSON.parse(event.body)
  console.log('data: ', body)
}
```

To extract values from your real git providers webhook check:

- gitlab webhook https://gist.github.com/jrichardsz/3d55df91181e3fb83089d08ada6809a8
- bitbucket webhook https://gist.github.com/jrichardsz/52edc692ea6876f6409f93d1d2b1e175
- github webhook https://gist.github.com/jrichardsz/d8017ec4195dd3cd51a5e4fc8ce9eb3e

At this point we have a cheap replacement of an entire continuous integration server like Jenkins, Travis, Aws Code Build, etc

## Github Webhook

If you were able to create the lambda and test it with an post http invocation (curl, postman, insomnia, etc), let's use that http url to register it as our github webhook


## Create the server

AWS rest apis are so powerful. So you could use the following snippet to create an EC2 with linux ready to use

https://gist.github.com/jrichardsz/f3ec44a044293b54af3dbff309fe5c83

This snippet should be inside of the aws lambda

## Build

We wil perform the build using docker, so your app should be dockerized. If not, contact me!! I want to dockerize any language or framework in the multiverse, except Microsoft Technologies.

Also in this cheapest way, we will perform the **docker build ...** inside of the same ec2 machine created by the aws lambda function. **This is not recommended for real enterprises**

## Deploy

Similar to the previous paragraph, the deploy **docker run ...** will be performed inside of the same ec2 machine created by the aws lambda function.

## Devops on every machine reboot

The only way to have a cheapest devops flow is to build and deploy in the same server. So we need to execute several linux bash commands at the start of ec2 (created by aws lambda function)

Again, AWS apis are so powerful, so you could use a feature called **user data** to attach a bash script to the ec2. So this script will be executed at the start of ec2 machine. 

```js
var instanceParams = {
    ImageId: 'ami-0b9064170e32bde34',
    InstanceType: 't2.micro',
    KeyName: 'some_key',
    UserData: Buffer.from(script_as_string_here).toString('base64'),
    MinCount: 1,
    MaxCount: 1
};
```

For more details check:

- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html
- https://gist.github.com/jrichardsz/f3ec44a044293b54af3dbff309fe5c83#file-index-v1-js-L30

## Devops script

The script should look like this:

```
# docker install if it don't exist
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli

# docker delete everything
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)

# download the new source code
git clone https://github.com/usil/foo.git

# build
docker build -t my_app .

# deploy
# change WXYZ to your app port
# add every required env var to your app
docker run -it --name my_app -p 80:WXYZ -e bar=baz my_app
```

## Lecture and image References

- https://gist.github.com/jrichardsz/f3ec44a044293b54af3dbff309fe5c83#file-index-v1-js-L30
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html
- https://stackoverflow.com/questions/66114552/aws-lambda-how-do-i-get-property-inside-event-body-it-keep-return-undefined
- https://www.geeksforgeeks.org/remove-all-containers-and-images-in-docker/
- https://stackoverflow.com/questions/41648467/getting-json-body-in-aws-lambda-via-api-gateway
- https://cloudkatha.com/how-to-run-hello-world-on-aws-lambda-in-5-minutes/
- https://docs.aws.amazon.com/lambda/latest/dg/urls-invocation.html
- https://gist.github.com/jrichardsz/cf8fcec5f652a0cca432120c15d8595f
- https://jrichardsz.github.io/devops/configure-webhooks-in-github-bitbucket-gitlab
- https://www.planttext.com/?text=LOv12iCm30JlUiMIUxvGyfFYrgejKErWhm_zVKdIG7eHcjr1QEaCZUFjuleYMD4iPI9QqoUj5f5j2IMv8XdlRfrQj25qJ0U0UU-mZfwdY_yOvl72KLUl7v6_Ey0yttxgFe_WT6NH4hV_lW00

## Conclusion

If you are using AWS and you need to save money in your startup, poc, etc you could use this approach. Very limited but cheap and only two aws services are required

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*fca_sikb4B8g4U55NHYbgA.png" width=500>

I will update the script, and try to reduce the manual steps in the following post.
