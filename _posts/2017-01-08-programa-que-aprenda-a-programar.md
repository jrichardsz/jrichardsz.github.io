---
layout: post
title: ¿Como crear un programa que aprenda a programar?  Parte 1
description: "Un programa que aprenda a programar, es algo muy complejo."
category: inteligencia-artificial
tags: [inteligencia artificial, ia, ai, series, ficcion]
comments: true  
---

Hace como 2 semanas una persona que vio algun código de reconocimiento de voz en mi cuenta de github, me contacto y su pregunta fue directa
"¿Como hago para que mi programa aprenda a programar?" Casi me caigo de mi silla. Estoy acostumbrado a preguntas sobre java, html, linux, etc pero nada de IA.

Analizemos la idea general : **Un programa que programe**

Para ello necesitariamos :

* Que el programa entienda lo que es "aprender"
* Definir el lenguaje que usara
* No necesito que programe de forma visual, asi que basta con que genere un archivo de código fuente en el lenguaje especificado.

# Que el programa entienda lo que es "aprender"

![tachikoma](https://ghostlightning.files.wordpress.com/2010/06/ozcghostintheshellstandalonecomplexe15machinesdesirantes-mkv_snapshot_09-04_2010-06-22_17-56-26.jpg){: .img-responsive }

Crear un programa que aprenda de la misma forma que aprende un humano es complejo. Grandes empresas trabajan en este asunto y tienen
avances interesantes, pero nada parecido a la forma de aprender de un niño recien nacido. Si esto ya estaría desarrollado, peliculas de ciencia ficción como Yo Robot, Skynet de Terminator, Chappie, etc serían realidad.

No se si haya robots que ya aprendan por si solos como lo hace un humano. Hay software o robots que saben diferenciar colores, rostros,
objetos, etc pero si analizamos bien , todo eso esta preprogramado. Ejemplo : Si un robot sabe diferenciar rostros de sus dueños es porque en su programación
hay algoritmos de reconocimiento facial que se ejecutan sobre cada imagen que captura la camara del robot y previamente se ha asociado los
rostros de sus dueños con un nombre de persona. Gracias a lo anterior es que se logra la ilusión de que el robot "ha aprendido a reconocer rostros" pero 
desde mi punto de vista no es que el robot halla aprendido algo, sino que esta ejecutando una secuencia de comandos para los que fue programado.

¿Que pasaría si en el cpu del robot, no le ponemos ni un solo algoritmo de reconocimiento facial, ni cargamos imagenes relacionadas a nombres?
El robot no podría procesar las imagenes que recibe de la cámara. 

## Chappie

[https://es.wikipedia.org/wiki/Chappie](https://es.wikipedia.org/wiki/Chappie)

![chappie](http://trilbee.com/wp-content/uploads/2015/03/chappie-1.jpg){: .img-responsive }

<iframe width="640" height="360" src="https://www.youtube.com/embed/l6bmTNadhJE" frameborder="0" allowfullscreen></iframe>

Les recomiendo esta película. Ahi muestra claramente lo que sería desarrollar un software o robot que aprenda como lo hace un niño.
El ser humano nace con un conjunto de característiscas o habilidades las cuales le permitirán aprender o sobrevivir en este mundo. Estas
caracteristicas mínimas vitales podrían ser en un robot , el reconocimiento de objetos, la capacidad de imitar sonidos, comportamientos, etc. Se esperaria que con 
estas características el robot pueda ir interpretando su entorno e ir aprendiendo, claro esta con el software necesario. Luego todo lo que aprenda un robot se puede replicar a mas 
robots y tendriamos muchos robots con la capcidad de apreder , caminando entre los seres humanos como en esta serie:

<iframe width="640" height="360" src="https://www.youtube.com/embed/HU4mwlTUXnc" frameborder="0" allowfullscreen></iframe>

En un siguiente post analizaremos los otros 2 puntos:

* Definir el lenguaje que usara
* No necesito que programe de forma visual, asi que basta con que genere un archivo de código fuente en el lenguaje especificado.

Esperando no haber sido muy abstracto, System.exit(0);
