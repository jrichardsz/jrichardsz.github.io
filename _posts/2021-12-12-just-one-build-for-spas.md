---
layout: post
title: Just one build for spas
description: "how to avoid build by each environment on spas"
category: devops
tags: [docker, reac, angular, vue, spas]
comments: true
---

If you are familiarized or tired of build your spa for testing and then another build for stagging and then another build for production, this post is for you!!

# Backend applications

In the backend applications (java, ruby, python, c#, php, etc) is very easy access to the environment variables and is a common practice use that for support variables by environment like testing, stagging, prod1, prod2, etc

With this feature, **backend applications** don't need any more files attached to the source code prefixed or suffixed containing key=value by environment:

- settings.stagging.properties
- settings.prod.properties

Also is a good practice avoid these kind of files because, we don't have that anyone could see my **settings.prod.properties**

Use environment as the config store is one of the famous: **The Twelve-Factor App**

https://12factor.net/config

![](https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2018/02/12/7andahalf.png)

# Modern Frontend applications: SPA

These kind of applications needs settings as any other application. Of course at this layer, we don't need the **database ip or password**. Instead of them, we need the apis or microservices urls, some ui settings, etc. If your web offer awesome user experience features, will need more parametrization. And if the developer needs to consume some microservice, this url should change in another environments:

- https://acme-api-test.com
- https://acme-api-stagging.com
- https://acme-api.com

# How spa solve its variables requirements?

Usually, spas uses classic files like:

- .dev.env .prod.env
- environment.dev.ts environment.prod.ts
- hardcoded values in constants.js or config.js

Remember that these kind of files go against to the https://12factor.net/ and the devops flows because human tasks are required

In another way if you achieve to automate that, if you are curious, after the build process (`npm run build`), in the minified and compressed javascript file ,you will find hardcoded the required variables.

### Demo of hardcoded configuration with react

In [this](https://github.com/jrichardsz/react-demo) repository, we have a classic react app:

![](https://i.ibb.co/b6t2j0H/react-classic-app-structure.png)

With this **.env** file:

![](https://i.ibb.co/MsJFQv1/env-file-react-js.png)

If you run the classic commands:

```
npm install
npm run build
```

You will obtain the statics assets:

![](https://i.ibb.co/yytBRJX/react-build-output.png)

And if you search the the content of .env file, you will find it in the minified file:

![](https://i.ibb.co/vHJ4SqH/hardcoded-value-in-spa-build.png)

That is why if one build was tested Q&A or staging environment, **another build is required** to production, because if we deploy the same build on the production environment, our spa will continue pointing to **testing urls**. Common solution is **build again** the spa passing some argument indicating the rigth environment like:

- --prod
- env=prod
- .env.prod
- etc

# How I propose to solve this?

Load the settings of the spa at the **start or entrypoint** of spa, consuming an http endpoint which returns a json with your required variables. Then just expose them to the rest of your spa modules, classes, etc

Basically at the entrypoint of your spa, you need to consume some http endpoint which returns you a json with the required settings:

```
{
 "securityApiBseUrl" : "https://security-api.com",
 "employeeApiBaseUrl" : "https://employee-api.com"
}
```

Then using some technique expose this json as variable to the entire spa application:

- [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage)
- some global variable like `global._settings`
- some javascript module or class
- store or another advanced approach

Finally you will need that this endpoint which returns you the spa settings **to be unique or easy to intuit**. I advice you to bind this endpoint to the server which render your static assets.

In nodejs, is **express** no matter if you are in the development stage (hot reload changes) nor angular, react or vue. All of those use: **express**

So, if you are in the development stage, your spa runs at **http//localhost:3000**, the settings endpoint should be something like **http//localhost:3000/settings** or **http//localhost:3000/config**. Analogously:

- **https//acme-test.com/settings** for testing
- **https//acme.com/settings** for production

If you achieve this, your build is **UNIQUE** and could be deployed on any environment or server, because don't have **hardcoded** values inside. Instead of that, **gets its configuration or settings from the server in which is deployed**

Here a post to read about how implement a static http server for spas:

https://jrichardsz.github.io/web/how-serve-spa-csr-react-angular-vue-webs


# nodeboot-spa-server

This is my implementation of the previous proposed solution. As it name say: is a server for spas or any static assets with the classic: **index.html**

This framework exposes an http endpoint ready to use at the same domain of the spa. This means that if your deploy your spa at **acme.com** your settings will be **acme.com/settings.json**.

You just need to install as any npm package

```
npm install https://github.com/usil/advanced-settings --save-dev
```

and add it to your package.json preferably in the **start script**

```
"start": "nodeboot-spa-server my-folder-with-assets",
```

In which **my-folder-with-assets** is the folder with the result of build. **This folder should contain the index.html**

# nodeboot-spa-server: variables option 1

Values could be read from environment variables, exactly like [create-react-app](https://create-react-app.dev/docs/adding-custom-environment-variables/) but for general purpose.

Just export some variables with prefix: **SPA_VAR_**

```cmd
export SPA_VAR_FOO=foo_value
export SPA_VAR_employeeApiBaseUrl=https://employee-api.com
```

These environment variables are exposed as json in the response of http endpoint **/settings.json**:

```
{
 "FOO" : "foo_value",
 "employeeApiBaseUrl" : "https://employee-api.com"
}
```

# nodeboot-spa-server: variables option 2

Instead of prefix your variables with **SPA_VAR_**, inspired on the [java spring boot framework](https://stackoverflow.com/a/35535138/3957754), you could create a **spa_settings.json** file at the root with these values:

```
{
 "foo" : "bar",
 "employeeApiBaseUrl" : "${EMPLOYEE_API_BASE_URL}"
}
```

Just ensure that that variable exist before the start of server:

```
#linux
export EMPLOYEE_API_BASE_URL=https://employee-api.com

#windows
set EMPLOYEE_API_BASE_URL=https://employee-api.com
```

Add the **-s settings.json** parameter:

```
"start": "nodeboot-spa-server dist -s settings.json -p 9000 --allow-routes",
```

Then start the spa server `npm run start` and  this framework, will evaluate the variable syntax and expose you this json:

```
{
 "foo" : "bar",
 "employeeApiBaseUrl" : "https://employee-api.com"
}
```


# nodeboot-spa-server: variables for development stage

In the developer machine, as I said, spas uses express as mini server. So if we need to add our settings endpoint, we need to access to express. Some kind of hack.

Follow these links to enable it for **angular**

- https://github.com/usil/nodeboot-spa-server#settingsjson-at-developer-stage
- https://github.com/usil/nodeboot-spa-server/wiki/Dev-Mode-:-Angular-12

I will add a snippet for react and vue. Until that, what you can do is just to mock the expected settings and at the entrypoint of your spa, do something like this:

```
var settingsUrl;
if(isDevEnvironment){
  settingsUrl = "http://localhost:1234/mock/settings.json"
}else{
  settingsUrl = "./settings.json"
}
```
