---
layout: post
title: How to properly document your system integrations?
description: "I will show you how to document and conduce the integration to the system events"
category: integration
tags: [documentation, uml]
comments: true
---

<img src="https://user-images.githubusercontent.com/3322836/224588811-2c51c66a-199c-41f7-9732-34c84801ac15.png" width=500>

If after the endless meeting with he final users related to new system integration requirements, the business analyst, developers and testers only have paragraphs of information in a word as deliverable, this post is for you.

I will show you how to document and conduce the integration to the system events with the aim to have a readable and measurable list or backlog ready to be designed and implemented.

## The problem

System integrations inside of a company are so important to reduce the user manually tasks or time required to complete some business process. Design and develop system integrations are not like the common requirements : web form or rest apis developments.

And summing to that if the system integration requirements are not well understood or correctly explained and argued to the final user, the only way is to implement a P2P (point to point) or request driven integration which is the most common and easy to develop but is a double-edged sword.

## The requirement

Let's imagine this current workflow: 

For any new employee in the HR system:

The user exports and excel and share to some IT guy who loads the an excel to the **Google Cloud Directory**

<img src="https://user-images.githubusercontent.com/3322836/224584670-b1a79810-0c4b-4edd-880a-921da993dba2.png" width=500>

And then for each employee which is a developer, an account should be created manually in github

<img src="https://researchcomputing.princeton.edu/sites/g/files/toruqf311/files/styles/freeform_750w/public/2021-02/Github.png" width=300>

## What does the user need?

SO after the endless meetings, the analyst team should deliver some kind of document with the landed requirements to the development team. So that's the question? How to map properly and intuitively the required integrations

## Drive the integrations to a system events

I got the idea from here: https://tyk.io/blog/api-design-methodologies/ 

<img src="https://tyk.io/wp-content/webp-express/webp-images/uploads/2020/04/tyk_api_modeling.jpg.webp" width=500>

and I complemented with a developed platform called "Eventhos" which I will talk about in another post.

Basically is a simple matrix:

<img src="https://user-images.githubusercontent.com/3322836/224586690-404d2164-dd10-4371-bfbc-93b9f0f25547.png" width=500>

This may seem simple, repetitive, or even a waste of time, but it is very helpful to estimate the development and to implement the integration driven to an events, not a p2p or request driven

## How to map the internal conditionals

Each row of the previous matrix will be an integration, but **How can we map properly the internal flows or conditionals of each integration?**

A simple flow chart and UML comes to our rescue:

- Flow chart
- Sequence diagram

If someone clap me, I will share my [Plantuml](https://www.planttext.com/) templates

## Flow chart

Describes the logic required in this integration

<img src="https://user-images.githubusercontent.com/3322836/221453242-79606b24-fcff-41d9-b2fd-f43b58f78f0d.png" width=500>

In the used example, the conditional to create a github account will be:

**If the employee is a software developer**

## Sequence Diagram

This diagram represents the interaction between objects, components, artifact, etc over a specific period of time for this specific integration

<img src="https://user-images.githubusercontent.com/3322836/221452972-8f28eedf-fff0-4d30-b2d7-5d2d43a3311b.png" width=500>

## Lecture and image References

- Front page initially image from : https://www.janbasktraining.com/blog/business-analysis-documentation/
- https://tyk.io/blog/api-design-methodologies/
- https://www.youtube.com/watch?v=WeEyg9QCeC0
- https://workspaceupdates.googleblog.com/2021/12/
- https://beyondplm.com/2015/06/18/how-plm-can-avoid-cloud-integration-spaghetti/

## Conclusion

If your analyst team is able to create the proposed matrix and for each row the respective flow chart and sequence diagram, before the development, I guarantee you that your developers will thank you because everything is well defined without a chance of doubts before to start the source code.

Also if you choose an event drive integration instead of p2p or request driven, your architecture will grow orderly, easy to maintain avoiding the so terrifying spaghetti integration

<img src="https://beyondplm.wpenginepowered.com/wp-content/uploads/2015/06/21-centure-spaghetti-integration.jpg" width=500>

In the next post I will talk about my own event driven platform and how it could help you to avoid the spaghetti integration
