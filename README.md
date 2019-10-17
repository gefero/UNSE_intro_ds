Docente: Germán Rosati

# Presentación y objetivo del curso:
Debido a su carácter de software libre y a la creciente comunidad de usuarios el lenguaje R se ha convertido en algo así como la lingua franca dentro del análisis estadístico. El presente seminario se propone realizar una introducción a algunos conceptos fundamentales de la programación estadística en R. A su vez, se hará énfasis en la implementación de análisis estadísticos básicos (descriptivos y regresiones) en R. A su vez, el curso presentará algunos elementos teóricos de la minería de datos/aprendizaje automático (balance sesgo-variancia, overfitting, etc.) y revisará algunos algoritmos para la estimación de árboles (ID4, C4.5, CART y random forest).

El curso se propone que los alumnos:

- se familiaricen con aspectos relevantes de la programación estadística en lenguaje R y con el llamado `tidyverse` en particular
- logren implementar e interpretar análisis estadísticos descriptivos y modelos de regresión en lenguaje R
- incorporen algunos conceptos fundamentales del data mining/aprendizaje automático,
- conozcan generalidades de algunos algoritmos para la generación de árboles de decisión (ID4, C4.5,CART y random forest) y su implementación en lenguaje R,
- logren identificar situaciones de aplicación de este tipo de modelos a problemas de investigación básica y aplicada

# Contenidos y materiales

## __Datos para trabjar__ 
- [Dataset Delitos CABA](data/delitos.csv)
- [Radios censales CABA](data/radios_info_gral.geojson)
- [Dataset Sistema Único de Atención CABA](data/sistema-unico-de-atencion-ciudadana-2016.zip)

- [Radios censales Santiago-La Banda](data_santiago/radios_santiago.geojson)
- [Google Places Santiago-La Banda](data_santiago/gplaces_sgo_la_banda_ed.geojson)

## __Clase 1.__ 
Elementos de programación estadística en R:* Objetos en R (vectores, matrices, data frames y listas). Introducción al `tydiverse`: data wrangling (`select()`, `filter()`, `arrange()`, `mutate()`. `summarise()`, `group_by()`, `left_join()`). Estructuras de control: `for`,`if`. Uso e implementación de funciones ad-hoc. Importación y exportación de datos (.csv, .txt, .tab, .sav, etc.).
- [Explicación y práctica guiada 1 - Notebook](clase1/C1_Prog_Est_R.nb.html)
- [Explicación y práctica guiada 1 - RCode](clase1/C1_Prog_Est_R.R)

- [Explicación y práctica guiada 2 - Notebook](clase1/C1_b_Prog_Est_R.nb.html)
- [Explicación y práctica guiada 2 - RCode](clase1/C1_b_Prog_Est_R.R)


## __Clase 2.__ 
Visualización y generación de gráficos en R:* Nociones de graficación (forma, color, tamaño, color). Niveles de medición y gráficos adecuados. Introducción a `ggplot2`: `ggplot()`, `geom_points()`, `geom_smooth()`, `aes()`, `facet_wrap()`, `facet_grid()`. Pipeline general de un proyecto con datos geográficos.
- [Explicación y práctica guiada 1 - Notebook](clase2/C2_Intro_tidy.nb.html)
- [Explicación y práctica guiada 1 - RCode](clase2/C2_Intro_tidy.R)

- [Explicación y práctica guiada 2 - Notebook](clase3/C3_Intro_tidy_2.nb.html)
- [Explicación y práctica guiada 2 - RCode](clase3/C3_Intro_tidy_2.R)


## __Clase 3.__ 
Introducción a los problemas de regresión y clasificación en R:*  Implementación y análisis de modelos de regresión lineal y logística. Evaluación del modelo: supuestos, ajuste, estimación de error de generalización. Extensiones del modelo lineal y logístico: variables cualitativas, no linealidad, etc. Funciones lm, glm y predict. Funciones `lm()`, `glm()` y `predict()`.

- [Explicación y práctica guiada - Notebook](clase4/C4_Intro_glm.nb.html)
- [Explicación y práctica guiada - RCode](clase4/C4_Intro_glm.Rmd.R)


# Bibliografía básica

+ [James, G., Witten, D., Hastie, T., Tibshirani, R. (2013), _An Introduction to Statistical Learning with Applications in R_, Berlin: Springer.](http://www-bcf.usc.edu/~gareth/ISL/)
+ [R Core Development Team, (2000), _Introducción a R. Notas sobre R: Un entorno de programación para Análisis de Datos y Gráficos_.]( https://cran.r-project.org/doc/contrib/R-intro-1.1.0-espanol.1.pdf)
+ [Tetor, P. (2011), _R Cookbook. Proven recipes for data analysis, statistics and graphics_, New York: O Reilly.](http://www.cookbook-r.com/)


# Requisitos para la cursada y aprobación

Conocimientos básicos de estadística descriptiva y cierta familiaridad con el modelo de regresión lineal y logística. Será útil (pero no absolutamente necesario) alguna experiencia en programación estadística (sea en SPSS, Stata o similar)
Para la aprobación del curso se requiere:

1. un mínimo de asistencia del 80% sobre el total de clases y
2. la entrega y aprobación de una monografía final

# Fuentes

El material para el curso fue extraído y transformado de diversas fuentes.

- Curso [R Progamming](https://www.coursera.org/learn/r-programming) - Coursera
- Curso [Progrmación Estadística en R](https://www.coursera.org/learn/programacion-estadistica-r) - Coursera
- Materiales didácticos de [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), escrito por James, Witten, Hastie y Tibshirani
- Materiales de [Kelly Black](http://www.cyclismo.org/tutorial/R/index.html#)
- [R for Data Science](https://r4ds.had.co.nz/)
- [Ciencia de Datos para Gente Sociable](https://bitsandbricks.github.io/ciencia_de_datos_gente_sociable/)
- [Quick R Tutorial](http://www.statmethods.net/index.html)
- [R Tutorial](http://www.r-tutor.com/)
- [R Cheat-Sheet](https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
- [R Reference Card](https://cran.r-project.org/doc/contrib/Short-refcard.pdf)
- [A very quick introduction to ggplot2](http://chrisladroue.com/extra/ggplot2Intro/introductionGGplot2/)
