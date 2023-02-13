---
layout: post
title: Webpack, the unknown hero of modern javascript frameworks and its power for javascript library makers - Part 1
description: "Basically I will show you how webpack is being used to give us powerful frameworks like angular, vue, react"
category: frontend
tags: [webpack, javascript]
comments: true
---

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*H6VFWLNP5JsNkVMSxBhMeA.png" width=500>

If you are one of the people for whom the visible is enough, this post is not for you. In the other hand if you have the need to understand the why of things, your creativity is in another level and your are a library maker, this post is for you.

Basically I will show you how webpack is being used to give us powerful frameworks like angular, vue, react

## Ancient days

In the ancient days the web development only required a plain editor and a couple of files

<img src="https://jc-backend-media-storage.fra1.digitaloceanspaces.com/jc-backend-media-storage/7caf6298f256d7fe97bfa32c4092ed27.png" width=500>

And the the relation between them was manually

<img src="https://images.theengineeringprojects.com/image/main/2019/12/Where-To-Add-Your-JavaScript-File-1.png" width=500>

That was enough for that days in which a few users, few requirements, few servers, one browser , etc were involved. 

Today these files are required yet, but there are not injected manually in the head, html is not binded manually with data, css is super advanced and other crazy features related to the modern web development

## SSR vs CSR

Nobody sane would use an SSR framework to develop a modern enterprise web. Maybe for landing pages (Wordpress, Drupal) but not for web in which the user experience should be in another level like Clickup.com or Trello:

<img src="https://clickup.com/images/main/teams/finance.png" width=500>

In SSR frameworks, the html is created in the server using some template engine and then is sent to the browser. You could detect this kind of frameworks if a server language is required: Java, php, python, ruby, c#, etc

In CSR frameworks, the html sent to the browser is minimal. The bundle javascript in in charge of renderize or create the content, mixing in real time: javascript, ajax and the data of microservices(json). You could detect this kind of frameworks if a server language is not required: Java, php, python, ruby, c#, etc except Nodejs.

So, remember this please: 

<img src="https://clipartart.com/images/free-remember-clipart.png" width=500>

Don't use a pure SSR for web development. SSR needs more cpu power so the warm earth will thank you!!

## Modern frontend stack

<img src="https://user-images.githubusercontent.com/3322836/216890297-fee8a338-3d6c-4a33-9039-91d50c36b38d.png" width=500>

Frontend frameworks are a hegemony today because only we have these options

<img src="https://miro.medium.com/max/1400/1*lC1kj3IeXoE8Z3OCKJoWkw.jpeg" width=500>

There are other but the previous listed are world wide known and there are a lot of jobs is you know one of them.

But if the modern browser continue requiring and index.html, main.css, main.js, there is oe question: 

How that framework does to convert a lot of files in these 03 files?

<img src="https://www.zoneofdevelopment.com/wp-content/uploads/2019/08/Capture4.png" width=500>

## Webpack

All of the previous listed frameworks (angular, react, vue) use webpack to do the magic. Here an example of the official angular github repository

<img src="https://user-images.githubusercontent.com/3322836/216892782-2e13997a-365e-4a6a-80d5-96c56c3b290f.png" width=500>

If I receive 50 claps, I will put here the vue and react examples.

Webpack is used for almost every feature that normal developer **assumes** but artisans or architects like me need to understand. Here a couple of examples


## Development mode with webpack

In the ancient (I hope that), developers opened its html development like this

<img src="https://qph.cf2.quoracdn.net/main-qimg-2d5f72c131cd04880ef461778a16d48d-pjlq" width=500>

But today when you run **npm run dev**, a url is opened in your default browser

<img src="https://user-images.githubusercontent.com/3322836/216893977-818be417-81a3-427e-9b8a-6e57724bfc4e.png" width=500>

This is thank you to a webpack feature called **DevServer** which is basically a nodejs express server and other nodejs features like listen changes on your workspace files to offer you **hot reload**. More details here:

https://webpack.js.org/configuration/dev-server/

## Minify or transpile with webpack

This part is tricky for juniors: **The Browser don't understand angular, react or vue**

<img src="https://jsmanifest.s3-us-west-1.amazonaws.com/posts/10-vscode-practices-to-hasten-your-react-development-process/something+react+components.JPG" width=500>

Browser needs a plain, old , clean and pure javascript which is called [Vanilla Js](http://vanilla-js.com/)

<img src="https://miro.medium.com/max/922/1*MNkpWU_sAEiVDg_fPD4CBA.png" width=500>

So yes, webpack is in charge of convert or more precisely **transpile** the react files to simple and clean vanilla js, index.html, etc with the famous **npm run build**

<img src="https://user-images.githubusercontent.com/3322836/216895831-6a1ba828-4131-45f1-b6da-e0166254d8d9.png" width=500>

## Webapck Loader

This is pure magic

<img src="https://champyin.com/images/webpack-loader-flow-with-pitch.png" width=500>

Webpack loader is the most interesting, amazing and useful webpack feature. Basically is a javascript method which is executed on every **build** (local or for prod) and pass for all the files in your workspace

```js
function loader(content) {
  // content could be the index.html, 
  // main.css , foo.ts
  // bar.js
}
```

So if you are a string artisan you could give free rein to your imagination like this:

Simple placeholder (@ACME_UI) to replace some special string by some other string. This could be done in the webpack loader

```js
import './App.css';
import HelloWorld from './components/HelloWorld'

const App = () => {
  return (
    @ACME_UI
  );
}
export default App;
```

Or instead of instance manually the js files, create your own [Dependency Injection Engine](https://www.techtarget.com/searchapparchitecture/definition/dependency-injection) like this annotation or decorator **@Autowired**

```js
class HelloComponent {
    first_name: string;
    last_name: string;

    @Autowired
    settings: object
  
    constructor(fname: string, lname: string)
    {
        first_name = fname;
        last_name = lname;
    }
    getName(): string
    {
        var fullname: string = first_name + last_name;
        return fullname;
    }
}
```

More details here https://webpack.js.org/loaders/

## Image References

- https://jeffroper.com/2019/09/26/the-rise-of-artisan-culture-and-the%E2%80%8B-churchs-worship-and-witness/
- https://journocode.com/en/tutorials/html-css-and-javascript-the-basics-part-ii/
- https://www.theengineeringprojects.com/2020/07/how-to-include-javascript-code-in-html-page.html
- https://www.zoneofdevelopment.com/2019/08/07/angular-cli/
- https://jsmanifest.com/10-vscode-practices-to-hasten-your-react-development-flow/
- https://medium.com/@Nick_C_Rose/react-vs-vanilla-javascript-f5af0a9305a2
- https://www.linkedin.com/pulse/how-test-production-build-react-js-app-locally-vinay-sharma-he-him-
- https://champyin.com/2020/01/28/%E6%8F%AD%E7%A7%98webpack-loader/


## Conclusion

Webpack is the unknown hero of almost every modern javascript framework and gives you the possibility to create your own framework like mine called [LinkStart.js](https://github.com/linkstartjs/linkstartjs) 

<img src="https://raw.githubusercontent.com/jrichardsz/static_resources/master/linkstart/linkstart-533X300.png" width=500>

Or extend the existent with you own awesome features

In the part 2, I will share how to use webpack loaders from the scratch