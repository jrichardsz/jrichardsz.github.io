---
layout: post
title: How serve or publish spa csr webs developed with react angular vue?
description: "react angular and vue are csr or spa ..."
category: web
tags: [spa, react, angular, vue, csr, pwa]
comments: true
---

Some guy tried to render react code directly with nodejs:

- https://stackoverflow.com/questions/69846608/create-app-wont-render-when-i-go-to-localhost/69877617#69877617

That is why I wrote this post :D, in order to explain how render react, angular or vue apps from simple to advanced mode :D

Let's start!!

# Concepts

**Server side rendering (SSR)** — the traditional rendering method, basically all of your page’s resources are housed on the server. Then, when the page is requested (commonly from web browsers), the Html, JS and CSS are downloaded. Also frameworks can dynamically can create the html based on backend logic and finally download it. At this point, a lot of frameworks offer wonders for creating apps in no time with "amazing" functionalities.

Technologies : java, c#, python, nodejs, etc

**Client side rendering (CSR)** — Which is sometimes called "Frontend rendering" is a more recent kind of rendering method, this relies on JS executed on the client side (browser) via a JavaScript framework. So, when page is requested, a minimal , little or empty index.html, css and js were downloaded. Here **javascript** is responsible to send or receive data and update a minimal section of the page **without an entire page refresh.**. Finally when user click or trigger some event, javascript will send or receive the **data** commonly to an api rest (json) using an async call ([ajax](https://medium.com/letsboot/basics-using-ajax-with-fetch-api-b2218b0b9691)).

Technologies : react, angular, vue, aurelia, jquery, pure javascript, etc


# How serve a CSR or SPA web?

In **developer stage** (laptop/pc) you just need to use some kind of hot reload server(usually nodejs) which translates react into a pure javascript code and link it to your browser.

These kind of servers are provided or developed by framework creators (angular, vue , react, etc). Usually are pre-configured on your package.json as: **npm run dev** or **npm run start**

In **testing/production** stage, you should not use the hot reload server. You should perform a build which translates react into a pure javascript. Usually is the command **npm run build** and the result are new files on some folder in your workspace: index.html, bundle.js. main.css, etc

These files are ready to published **on any http server** from minimal to a complex servers:

- apache
- [nginx](https://gist.github.com/jrichardsz/547c09a43a3c61b82c2d385af1de0e7c#file-docker-nginx-static-server-md)
- haproxy
- tomcat
- widfly
- IIS
- free/paid web ftp services
- any decent server on any technology capable to serve html content.

# SPA in Developer stage

In react for example, if you are using **create-react-app** in a correct and standard way, there is a **start** script in your package.json ready to use:

```
"scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test --env=jsdom",
    "eject": "react-scripts eject"
}
```

Is advice you to change it from **start** to **dev** to make it more intuitive. Let empty the start script to be correcltly configured for the next stage.

# SPA in Testing/Production stage: Basic Mode

If your react code is ready to be tested or used by real users in the real world, and your **create-react-app** workspace is correct and standard, these are the required and minimal steps:

- install a minimal nodejs http server
  - `npm install http-server --save`
- add this in your script **main**:
  - `"start": "http-server ./build"`
- execute `npm run build`
- if there is no errors and your static files are created(index.html, css, js, etc), perform:
  - `npm run start`

For more information (custom port, etc) check this minimal nodejs http server implementation:

- https://www.npmjs.com/package/http-server

# SPA in Testing/Production stage: Docker Mode

If your package.json has correctly configured the standard scripts:

- npm run build
- npm run start (with http-server or another)

You could use Docker to deploy it on any linux server in this universe:

```
FROM node:14
COPY . /opt/
WORKDIR /opt/
RUN npm install
RUN npm run build
ENV PORT 8080
EXPOSE 8080
ENTRYPOINT ["npm","run","start"]
```

Linux is the only option for real environments. **Windows & Mac are just for developer stage**


# Advanced Server

What if your requirement needs:

- user session
- login/logout feature
- user inactivity expiration
- jwt oauth2 token refresh
- any other feature that react or any CSR/SPA was not designed for

In this case you need an advanced server implemented on some technology like: nodejs, java, python, php, etc

These implementation:

- should expose you endpoints like: `/login, /logout` ready to be called from your react/angular/vue
- should handle the user session with any common way: memory, redis, mongo, etc
- offer a login : basic auth, google, microsoft, etc

My first attempt was:

https://github.com/jrichardsz-software-architect-tools/geofrontend-server

I planning a revamp with more features and unit tests.

# Advanced API/Microservice


All of the features explained in the previous paragraph could be implemented on any backend rest api or microservice.

With that, your CSR/SPA builds will still be **STATIC** and **WON'T NEED** any crazy http server. Just the basic as explained at the start of this post.

---

That's all

Hope it helps!
