---
layout: post
title: RAD Rapid application development for users, roles and pages with wordpress
description: "RAD Rapid application development for users, roles and pages with wordpress"
category: wordpress
tags: [wordpress]
comments: true  
---

Mi brother start working in AN education organization. He and his team will have a proof of concept related to adopt some physical educations methodologies to our country. So, as I see everything as a change to develop something interesting, I said : Do you need a system for your proof of concept?. The answer was : Yes I need a simple page to register, students, teachers and admins to create student records.

Which are my options to do that calling to my experience ?

- Frontend (Simple pages)
  -  Develop some java classes with java server pages framework (deprecated)
  -  Jquery
  -  React & Angular
  -  Some CMS

- Backend (Simple CRUD)
  - Java
  - NodeJs
  - Python
  - C++

- Database 
  - Mysql of course!!  
  - Mongodb  
  - Firebase (I only read one post about this)  
  
- Security
  - Login
  - Create users
  - Create roles
  - Create mapping between user and roles
  - Create mapping between pages and roles
  

![how-many-days-59a229.jpg]({{ site.url }}/images/how-many-days-59a229.jpg)

In this post I want to show you how to achieve this requirements in a simple way. I hope this could help you in a mockup design, MVP or simple system.

![wordpress](https://blogs.protegerse.com/wp-content/imagenes/wordpress.jpg)

# Install wordpress

In my next post I will show you how configurate a wordpress site using one my prefered platforms : openshift

# Wordpress plugins

This are the required plugins:

![wordpress-plugins.png]({{ site.url }}/images/wordpress-plugins.png)

	
- Page Restrict
  - Set login as requirement to page access	

- Remove Dashboard Access
  - Disable dashboard wordpress for users
  
- Restrict Content by Role
  - Choose who can view a page
  
- User Role Editor
  - Create roles
  

# Steps

### Create a new role using "User Role Editor" plugin 

![wordpress-user-role-editor.png]({{ site.url }}/images/wordpress-user-role-editor.png)

### Create some users using wordpress web console (plugin not required) and select a role

![wordpress-set-role.png]({{ site.url }}/images/wordpress-set-role.png)

### Create some pages using wordpress web console (plugin not required) and :

- Set restriction page in order to force login for this page

![wordpress-restriction-page.png]({{ site.url }}/images/wordpress-restriction-page.png)

- Restrict acces by role

![wordpress-restrict-roles.png]({{ site.url }}/images/wordpress-restrict-roles.png)

For example , in the previous image , only users with my_custom_role and administrator role could access to this page.

- Restrict Access to Content and Sub Content 

![wordpress-subcontent.png]({{ site.url }}/images/wordpress-subcontent.png)

- Configure a custom error page with a message like : "you don't have access to this page"

![wordpress-error-page.png]({{ site.url }}/images/wordpress-error-page.png)

# Tests

For this example :

- I have an user with role manager 
- I have page called "mantenimiento" with force login and only accessed by role manager.

### Test 01 : No logged user try to access to "mantenimiento" page 

Result : User is redirected to error page

### Test 02 : Logged user without manager role try to access to "mantenimiento" page 

Result : User is redirected to error page

### Test 03 : Logged user with manager role try to access to "mantenimiento" page 

Result : User can access to "mantenimiento" page

