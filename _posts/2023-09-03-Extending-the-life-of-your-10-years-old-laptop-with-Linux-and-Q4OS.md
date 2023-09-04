---
layout: post
title: Extending the life of your 10 years old laptop with Linux and Q4OS 
description: "Revive your 10 years old laptop with linux and Q4OS"
category: linux
tags: [linux]
comments: true
---

<img src="https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/db2080c8-5563-4739-82f9-1af110d4b4d3" width=500>
--- 

If you have a cheap or expensive(at the time) laptop with more than 5 years old and you want it to keep living for any reason (like love, saving or helping the environment) follow this post to install linux in your laptop and keep rolling more years.


## Reasons

The use of linux is not only a necessity for programmers, it is also a grain of sand to protect the planet. Some will say that it is contradictory and to protect the planet all the technology should disappear. But a world without computers would cause another problems. So if you use a computer or laptop, with linux you are contributing to the environment care.


## Planned obsolescence

In economics and industrial design, planned obsolescence (also called built-in obsolescence or premature obsolescence) is a policy of planning or designing a product with an artificially limited useful life or a purposely frail design, so that it becomes obsolete after a certain pre-determined period of time upon which it decrementally functions or suddenly ceases to function, or might be perceived as unfashionable. The rationale behind this strategy is to generate long-term sales volume by reducing the time between repeat purchases (referred to as "shortening the replacement cycle"). It is the deliberate shortening of a lifespan of a product to force people to purchase functional replacements. Source: https://en.wikipedia.org/wiki/Planned_obsolescence

7 Examples Of Planned Obsolescence

- Slowed Down iPhones. 
- Protected Ink Cartridges. 
- Marginally Modified Textbooks. 
- Fast Fashion, Low-Quality Clothes. 
- Yearly Updates On Cars. ...
- Unrepairable Consumer Electronics. 
- Short Lasting Light Bulbs.

Source: https://durabilitymatters.com/planned-obsolescence/

## Earth warming

How much CO2 does a laptop produce? The average estimated carbon footprint of a laptop is around 422.5 kgs, which includes the carbon emissions during the production, transportation and first 4 years of use. Source: https://circularcomputing.com/news/carbon-footprint-laptop/

The carbon footprint of a Dell laptop, including raw materials consumption, manufacturing, product use, and end-of-life recycling potential, is between 300 and 400 kgs of CO2e. This is equivalent to drinking 2,401l of orange juice or driving 1,200km in an SUV. Source: https://8billiontrees.com/carbon-offsets-credits/carbon-footprint-of-a-laptop/

## Let's start

In this time, I choose an os that  I just met: 

- Q4OS - desktop operating system - https://q4os.org/

I tried in a laptop with 2gb RAM and more than 75% was free after installing this system.

**CHARGE THE BATTERY (full) before this procedure.**

> **Note: There is some minimal probability of your laptop become useless due to some low level error, insufficient battery, etc.**

## #1 Download the iso

Go to https://q4os.org/downloads1.html and select the LTS(long time support)

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/dcd1ca73-60a3-42fa-85a1-56284563fd7d)

Then download it

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/c2299ba9-04d2-4e5c-ae29-0e073a53fa6c)

If it works for you (some months of usage) and you can, you could donate a few dollars to the developers team.

This will download an .iso file from https://sourceforge.net/projects/q4os/

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/b0cfeae0-cfec-40a5-af90-4f4c95e5072c)

.iso files is so common to install or try operative systems (windows and linux)

## #2 Burn the iso into your USB

Only an usb (pen drive) with at least 2gb RAM is required. If you are new in the iso usage, I advice you a program with a dog name: **Rufus** : https://rufus.ie/en/

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/6acbee90-96c0-4a65-aa0f-2c152d06ca02)

Download and open it

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/ec1b1d13-a231-4a61-9629-7662f31e9608)

Before the usb connection, you will see nothing in the device selection:

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/852657d4-3d6a-470c-9a11-15685a8e8512)

After the usb connection, you should see your USB. **BE CAREFULL WITH THIS SELECTION, BECAUSE IF YOU CHOOSE ANOTHER DEVICE, THE CONTENT WILL BE DELETED**

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/7fade66c-6ec0-45b9-8702-9311c8c9d791)

After tht, select the .iso file:

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/176fcf1b-bbea-409a-b7a8-b71d03259f80)

If you are not an expert of partitions, boot, file systems , etc keep the  default values

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/64edf327-140c-457b-8c3e-c0a18daae802)

Finally press start

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/baf8da23-a347-4e38-8af6-89f7d630107d)

After some minutes you should see a message indicating you that the usb is ready.

## #3 Laptop boot

If you are new in laptop/computer os installation, this could be hard. I advice to googling something like this with your model:

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/9c3dabe8-4c85-4d2d-8a24-d616cc3f9930)

Basically is to find a key to enter the boot menu and if your usb is connected and well burned (*.iso file) you should see it. 

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/8322c437-bf32-41d0-b882-a0fc83d421e2)

Choose it and let the magic begin

> Note: Sometimes due to manufacturers ambition, the BIOS is protected or hard to boot. It is like the manufacturer don't want the usage of linux. If this is your case, I will happy to help you (after your research of course)

## #4 Q4os Installation

After a success usb boot, you should see something like this

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/357f5c19-dba2-4392-b0c7-3cf05125133c)

Chose the first option. You should see this log

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/aeb3f4ff-1834-4a37-89d5-ca5d17e59633)

Then, press OK

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/466a0e0f-f403-4272-a008-9e7b0499bb10)

Configure your display according to your needs

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/76f0f272-a6e5-4522-8b4a-ed2163ff5949)

Select your preferred language

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/72591b92-1dec-4d71-a0e2-712f70365f19)

After some loading, you should see a desktop. Click on "Install Q4OS"

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/8ad1c92a-31c5-4e44-8915-02dd2c77c80b)

Choose your language again and next

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/faaf6510-f52f-4482-a11e-5824f9a0f0dd)

Choose your time zone and next

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/de27aa0d-ab77-4176-be14-f484e0967820)

Choose your keyboard layout and next

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/0023f1eb-854d-465d-96c7-c8dcb23a0c55)

If you are new in Linux, choose "Q4OS Desktop"

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/f6aec0e5-feeb-4da4-aad6-fb151a58aa5d)

**THIS PART IS SENSIBLE**

- If you are bored of windows (update, lags, freezing, virus, etc) choose the first option "Erase DIsk"
- If you want to have windows & linux (dual boot), choose the other option but you should have some experience with partitions

In this post ww will choose "Erase Disk" because windows sucks!!

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/ea09af2c-3a10-450c-8fea-86de80a577ec)

> Note: If you have an SSD drive, you could choose it to discover new velocity levels in your new OS

If you are paranoid, you could choose the encrypt option. So if your machine is stolen , nobody sane will be able to see your content

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/bad99218-b94a-45f4-a80d-4ab36b8aa189)

Then, fill the classic form and next

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/ba2de215-70ea-404c-a483-65e2c55f3f3f)

Check the summary and click on "install"

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/18e2cbee-7b6d-4e9c-a807-8bea854ca1e3)

Wait some minutes

![image](https://github.com/jrichardsz/jrichardsz.github.io/assets/3322836/b0e9ee49-1e2c-4b95-9d3d-0ddfc2449cc9)
