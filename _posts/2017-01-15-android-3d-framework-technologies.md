---
layout: post
title: ¿Como crear un modelo 3D o mesh en android?
description: "Un programa que aprenda de forma autónoma, es algo muy complejo."
category: 3d
tags: [android, mesh]
comments: true  
---

Hace unos meses tengo un proyecto en mente. Uno relacionado a crear un objeto sobre un plano. Este objeto seria lo más parecido a un humanoide, avatar o personaje de un juego. Todo lo anterior en android.

![human-3d-model]({{ site.url }}/images/human-3d-model.jpg){: .img-responsive }

Encontré frameworks de 3D orientados a juegos pero todos requerían descargar muchos archivos e incluso un IDE propio.

# Sería genial un framework cuyo código sea algo como

<script src="https://gist.github.com/jrichardsz/b3166e9c2fe14e6aaaf3b158df517b34.js"></script>


Así como la clase HumanTemplates, habría un GeometricTemplates para figuras geométricas y muchas mas por defecto siguiendo una clasificación
como la que se propone en este documento de **Accelerate Learning**:

[Classifying Matter](http://www.katyisd.org/campus/KDE/Documents/Second%20Grade/Classifying%20Matter.pdf)

El framework estaria desarrollado para facilitar la creación de modelos customizados para que los entusiastas, usando github puedan subir sus propios diseños formando 
así una basta colección de objetos listos para ser usados. 

Algo como esto :

![community-3d-models]({{ site.url }}/images/community-3d-models.png){: .img-responsive }

[https://www.pinterest.com/pin/353743745711398467/](https://www.pinterest.com/pin/353743745711398467/)

Se imaginan un mecanismo para grabar un video a una persona u objeto y que sea el input de otra librería y que esto nos arroje un archivo,
con todas las coordenadas del modelo 3D (creo que esto ya existe, si lo encuentro, lo compartiré)

# Buscando Frameworks

## OpenGL 

Por ahi encontre un código el cual no requería descargar ninguna librería, es decir que solo necesita el core estandard de android para ejecutarse.

Solo se necesitó 3 clases java : Cube.java, OpenGLRenderer.java y OpenGLDemoActivity.java

La clase Cube no era nada del otro mundo. Basicamente se definen los vertices y demas temas geometricos relacionados a un cubo:

<script src="https://gist.github.com/jrichardsz/7b6635958bf6249d9a50e574c7d9d4d9.js"></script>

La clase OpenGLRenderer, instancia a la clase Cube y le asigna algo de movimiento:

<script src="https://gist.github.com/jrichardsz/5338d8f59f19d42e49e72e29760c5a8a.js"></script>

Finalmente la clase main de android, el Activity. Esta clase usa el OpenGLRenderer

<script src="https://gist.github.com/jrichardsz/74ba07b0f157fbf2c27442f9626707b2.js"></script>

El proyecto android completo lo pueden encontra aquí **TODO**

No lo vi tan complejo. Un momento, es solo un cubo. Osea si necesito todo un avatar no hay forma que pueda hacerlo con solo android.

Necesitaré de alguna librería. 

# High-End 3D Graphics with OpenGL ES 2.0

Tratando de entender como funcionan los modelos 3D, encontre esta excelente documentación:

[http://www.nxp.com/assets/documents/data/en/application-notes/AN3994.pdf](http://www.nxp.com/assets/documents/data/en/application-notes/AN3994.pdf)

Tambien encontre algo llamado ***obj** files en este post : 

[Looking for tutorials on drawing shapes with OpenGL ES 1.0 in Android](http://stackoverflow.com/a/10308822/3957754)

Al parecer se tratan de archivos que contiene data sobre modelos 3D los cuales cuentan con librerias en muchos lenguajes para poder visualizarlos.

[http://www.rozengain.com/blog/2010/05/17/loading-3d-models-with-the-min3d-framework-for-android/](http://www.rozengain.com/blog/2010/05/17/loading-3d-models-with-the-min3d-framework-for-android/)


# Rajawali

En el siguiente post les contare como me fue con esta librería  **3D engine for Android based on OpenGL ES 2.0/3.0** la cual al parecer puede leer archivos *.obj entre otras cosas.

[https://github.com/Rajawali/Rajawali](https://github.com/Rajawali/Rajawali)

Esperando que lo anterior sea de utilidad a alguien.

System.exit(0)
