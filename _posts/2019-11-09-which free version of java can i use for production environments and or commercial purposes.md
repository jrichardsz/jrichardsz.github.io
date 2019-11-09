---
layout: post
title: Which free version of java can I use for production environments and or commercial purposes?
description: "Augmented Reality with AR.js"
category: development
tags: [augmented reality ar]
comments: true  
---

![java dead](https://raw.githubusercontent.com/jrichardsz/static_resources/master/java/java-dead.jpeg)

While I was in a dockerization project in my current job, I got this doubt: Which java can I use?

This doubt is due to :

![java download alert](https://raw.githubusercontent.com/jrichardsz/static_resources/master/java/java-8-license-change-red-warning-alert.png)

So after some researches I got these conclusions:

- (0) Oracle **does not show any message related to license changes** for java 4,5,6 y 7 downloads. So we can use them, accepting issues and security problems.
- (1) Since the java 8 update at **April 16, 2019 8u221**, all versions and updates for (java 8,9,10,11 y 13) has no cost **just** for **personal use and development purposes**. Any other use, needs a **Commercial License**
- (2) Legacy versions prior to 7, does not have and will not have any update. Maybe a sales contact could be a solution if an update in these versions are required for Legacy Systems Support.
- (3) If I want to use java 8 oracle version for **commercials purposes** and **FREE**, I need to use a previous version of **April 16, 2019 8u221 update**
- (4) An alternative to oracle java 8 version for **commercials purposes** and **FREE** are these [java open implementations](https://gist.github.com/jrichardsz/83db09163ca9a0db4c9cd4f91cbf0598)
- (5) Oracle Java 9 y 10 has reached end of support.  
  - https://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html
  - https://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html


# Heroku

According to heroku, which offer java for productions purposes, offer this versions

- Java 7 - 1.7.0_232
- Java 8 - 1.8.0_222
- Java 11 - 11.0.4
- Java 12 - 12.0.2
- Java 13 - 13.0.0

Source: https://devcenter.heroku.com/articles/java-support#supported-java-versions

I will research more about java on heroku.
---

# Summary

According to my conclusions:

- If your development strictly needs or was developed with **JDK 8**, you can use Oracle Java SE 8 [JDK 8u202 and earlier versions](https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html?printOnly=1) for **FREE** and **commercial purposes** accepting issues and security problems.

- If You can revamp your development **and** you want still **FREE**, **and** you want to have improvements and security updates, You must use one of these  [java open implementations](https://gist.github.com/jrichardsz/83db09163ca9a0db4c9cd4f91cbf0598)?

---
# References

- [My stackoverflow question](https://stackoverflow.com/questions/58250782/which-free-version-of-java-can-i-use-for-production-environments-and-or-commerci)
- [End of Public Updates for Oracle JDK 8](https://www.oracle.com/technetwork/java/java-se-support-roadmap.html)
- [The Oracle JDK License has changed for releases starting April 16, 2019.](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Official List of updates and release versions](https://www.oracle.com/technetwork/java/javase/8u-relnotes-2225394.html)
- [Java official supported versions](https://www.oracle.com/technetwork/java/javase/downloads/index.html)
- [Oracle Java 8 download alert](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
- [Oracle Java 8 unsupported but free version](https://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html?printOnly=1)
- [Java 4 legacy official download page](https://www.oracle.com/java/technologies/java-archive-javase-v14-downloads.html)
- [Java 5 legacy official download page](https://www.oracle.com/java/technologies/java-archive-javase5-downloads.html)
- [Java 6 legacy official download page](https://www.oracle.com/java/technologies/javase-java-archive-javase6-downloads.html)
- [Java 7 legacy official download page](https://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html)
- [Oracle Java Archive](https://www.oracle.com/technetwork/java/archive-139210.html)
- [Home image](https://arstechnica.com/information-technology/2016/07/how-oracles-business-as-usual-is-threatening-to-kill-java/)
