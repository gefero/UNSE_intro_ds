## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, warning=TRUE, highlight=TRUE, echo=TRUE)


## ----message=FALSE, warning=FALSE----------------------------------------
library(tidyverse)


## ------------------------------------------------------------------------
delitos <- read.csv("../data/delitos.csv")
delitos <- delitos %>%
                filter(latitud!=0, longitud!=0)
str(delitos)


## ----message=FALSE, warning=FALSE----------------------------------------
library(lubridate)
delitos <- delitos %>% 
                mutate(fecha=ymd(fecha))


## ------------------------------------------------------------------------
set.seed("99")
muestra_de_fechas <- delitos %>% 
    sample_n(5) %>% 
    select(fecha)

muestra_de_fechas



## ------------------------------------------------------------------------
set.seed("99")
muestra_de_fechas <- delitos %>% 
    sample_n(5) %>% 
    pull(fecha)

muestra_de_fechas


## ------------------------------------------------------------------------
wday(muestra_de_fechas)


## ------------------------------------------------------------------------
wday(muestra_de_fechas, label=TRUE)


## ------------------------------------------------------------------------
month(muestra_de_fechas)


## ------------------------------------------------------------------------
year(muestra_de_fechas)


## ------------------------------------------------------------------------
delitos %>%
        select(fecha) %>%
        ggplot() +
                geom_bar(aes(x = month(fecha, label = TRUE)))


## ------------------------------------------------------------------------
delitos %>% 
    ggplot() +
        geom_bar(aes(x = month(fecha, label = TRUE), fill = tipo_delito))



## ------------------------------------------------------------------------
delitos %>% 
    ggplot() +
        geom_bar(aes(x = month(fecha, label = TRUE), fill = tipo_delito),
                 position = "fill")


## ------------------------------------------------------------------------
delitos %>% 
    ggplot() +
        geom_bar(aes(x = month(fecha, label = TRUE), fill = tipo_delito),
                 position = "dodge")


## ----echo=TRUE-----------------------------------------------------------
###


## ----echo=TRUE-----------------------------------------------------------
###


## ----echo=TRUE-----------------------------------------------------------
###


## ------------------------------------------------------------------------
###


## ------------------------------------------------------------------------
###


## ------------------------------------------------------------------------
delitos %>%
        group_by(barrio, comuna) %>%
        summarise(tot=n()) %>%
        filter(tot==max(tot)) %>%
        arrange(comuna)


## ------------------------------------------------------------------------
library(ggmap)


## ------------------------------------------------------------------------
bbox <- c(min(delitos$longitud, na.rm = TRUE),
          min(delitos$latitud, na.rm = TRUE),
          max(delitos$longitud, na.rm = TRUE),
          max(delitos$latitud, na.rm = TRUE))

CABA <- get_stamenmap(bbox = bbox, 
                      maptype = "terrain-background")


## ------------------------------------------------------------------------
ggmap(CABA)


## ------------------------------------------------------------------------
CABA <- get_stamenmap(bbox = bbox, 
                      maptype = "toner-lite")

ggmap(CABA)



## ------------------------------------------------------------------------
ggmap(CABA) +
    geom_point(data = delitos, aes(x = longitud, y = latitud, color=tipo_delito),
               size = 0.1, alpha = 0.1)


## ------------------------------------------------------------------------
ggmap(CABA) +
    geom_point(data = delitos, 
               aes(x = longitud, y = latitud, color = tipo_delito),
               size = 0.1, alpha = 0.1) +
    guides(color = guide_legend(override.aes = list(size=2, alpha = 1))) 


## ----fig.height=12, fig.width=12-----------------------------------------
ggmap(CABA) +
    geom_point(data = delitos, 
               aes(x = longitud, y = latitud, color = tipo_delito),
               size = 0.2, alpha = 0.1) +
        facet_wrap(~tipo_delito) +
        guides(color = guide_legend(override.aes = list(size=2, alpha = 1))) +
        theme(strip.text.x = element_text(size=7.5))



## ----fig.height=12, fig.width=12-----------------------------------------
ggmap(CABA) +
    geom_density2d(data = delitos, aes(x = longitud, y = latitud, color = stat(level))) +
        scale_color_viridis_c() + 
        facet_wrap(~tipo_delito) +
        theme(strip.text.x = element_text(size=7.5))



## ----fig.height=12, fig.width=12-----------------------------------------
delitos <- delitos %>% 
    mutate(hora_base = hour(hms(hora)))

ggmap(CABA) +
    geom_density2d(data = delitos, aes(x = longitud, y = latitud, color = stat(level))) +
        scale_color_viridis_c() + 
        facet_wrap(~hora_base, nrow=4) +
         labs(title = "Concentración espacial de delitos",
         subtitle = "según hora del día")
        


## ----fig.height=12, fig.width=12-----------------------------------------

delitos <- delitos %>%
        mutate(dia=wday(ymd(fecha), label=TRUE))

ggmap(CABA) +
    geom_density2d(data = delitos, aes(x = longitud, y = latitud, color = stat(level))) +
        scale_color_viridis_c() + 
        facet_wrap(~dia, ncol=3) + 
        labs(title = "Concentración espacial de delitos",
         subtitle = "según día de la semana")



## ----fig.height=12, fig.width=12-----------------------------------------
###


## ----fig.height=12, fig.width=12-----------------------------------------
###

