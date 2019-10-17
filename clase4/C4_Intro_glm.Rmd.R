## ----include=FALSE-------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, warning=TRUE, highlight=TRUE, echo=TRUE)


## ----warning=FALSE, include=FALSE----------------------------------------
library(tidyverse)
library(lubridate)
library(sf)


## ------------------------------------------------------------------------
delitos <- read.csv('../data/delitos.csv')

delitos <- delitos %>% 
        filter(latitud!=0 | longitud!=0) %>%
        mutate(fecha=ymd(fecha),
               hora=hms(hora))


## ------------------------------------------------------------------------
radios_gral <- st_read('../data/radios_info_gral.geojson')
str(radios_gral)


## ------------------------------------------------------------------------
ggplot() + geom_sf(data = radios_gral)


## ------------------------------------------------------------------------
delitos <- st_as_sf(delitos, 
                    coords=c('longitud', 'latitud'), 
                    crs=4326)


## ------------------------------------------------------------------------
ggplot() + 
        geom_sf(data=radios_gral) + 
        geom_sf(data=sample_n(delitos,1000), aes(color=tipo_delito)) + 
        facet_wrap(~tipo_delito)


## ------------------------------------------------------------------------
delitos_radio <- st_join(delitos, 
                          radios_gral, 
                          join = st_within) %>%
        as_tibble() 
head(delitos)


## ------------------------------------------------------------------------
radios_delitos <- delitos_radio %>%
        group_by(RADIO_ID) %>%
        summarise(n_delitos=n()) %>%
        left_join(x=radios_gral)


## ------------------------------------------------------------------------
str(radios_delitos)


## ------------------------------------------------------------------------
ggplot() +
        geom_sf(data=radios_delitos, 
                color=NA,
                aes(fill=n_delitos)) + 
        scale_fill_viridis_c() + 
        theme_minimal()



## ------------------------------------------------------------------------
radios_delitos <- radios_delitos %>%
        mutate(n_delitos_hab= n_delitos / POBLACION,
               dens_pob=POBLACION/AREA_KM2)


## ------------------------------------------------------------------------
ggplot() +
        geom_sf(data=radios_delitos, 
                color=NA,
                aes(fill=n_delitos_hab)) + 
        scale_fill_viridis_c() + 
        theme_minimal()



## ------------------------------------------------------------------------
radios_delitos <- radios_delitos %>%
        mutate(n_delitos_hab = ifelse(n_delitos_hab >=0.6, 0.6, n_delitos_hab))



## ------------------------------------------------------------------------
radios_delitos %>%
ggplot() +
        geom_sf( 
                color=NA,
                aes(fill=n_delitos_hab)) + 
        scale_fill_viridis_c() + 
        theme_minimal()


## ------------------------------------------------------------------------
radios_delitos <- delitos_radio %>%
        group_by(RADIO_ID, tipo_delito) %>%
        summarize(n=n()) %>%
        spread(key = tipo_delito, value = n) %>%
        left_join(x=radios_delitos) %>%
        replace(., is.na(.),0) %>%
        rename(hom_doloso='Homicidio Doloso',
               hom_segvial='Homicidio Seg Vial',
               robo_noviol='Hurto (Sin violencia)',
               hurto_auto = 'Hurto Automotor',
               les_segvial='Lesiones Seg Vial',
               robo_viol='Robo (Con violencia)',
               robo_auto='Robo Automotor'
               )



## ------------------------------------------------------------------------

radios_delitos<- radios_delitos %>%
        mutate(homicidio = hom_doloso + hom_segvial,
               robo_automovil = hurto_auto + robo_auto) %>%
        select(-hom_doloso, -hom_segvial, -hurto_auto, -robo_auto)
        


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----

radios_delitos <- radios_delitos %>%
        mutate(p_hognbi= HOGARES_NBI / HOGARES * 100) %>%
        replace_na(list(p_hognbi=0))


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----

model <- lm(formula = n_delitos~ AREA_KM2, data=radios_delitos)



## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
summary(model)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
names(model)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
model$coefficients


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
coef(model)
confint(model,level=0.95)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
predict(model, data.frame(AREA_KM2 = c(1, 10, 100), interval = "prediction"))


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
ggplot(data=radios_delitos, aes(x=AREA_KM2, y=n_delitos)) + 
        geom_point() + 
        geom_smooth(method='lm')


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
select(as.data.frame(radios_delitos), -c(RADIO:HOGARES_NBI,geometry)) %>%
        cor(method = 'pearson')


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
select(as.data.frame(radios_delitos), -c(RADIO:HOGARES_NBI,geometry)) %>%
        cor(method = 'pearson') %>%
        as.data.frame() %>%
        mutate(Var1 = factor(row.names(.), levels=row.names(.))) %>% 
        gather(key = Var2, value = value, -Var1, na.rm = TRUE, factor_key = TRUE)  %>%
        ggplot(aes(x=Var1, y=Var2, fill=value)) +
                        geom_tile() + 
                        scale_fill_viridis_c()


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----

radios_delitos_l <- radios_delitos %>%
        select(n_delitos, everything(), -c(RADIO:HOGARES_NBI, n_delitos_hab, robo_noviol:robo_automovil)) %>%
        st_set_geometry(NULL)

model <- lm(n_delitos~., data=radios_delitos_l)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
summary(model)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----

library(car)
vif(model)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
model <- lm(n_delitos~. -tasa_cal_construct_insuf -tasa_cal_serv_insuf -tasa_cal_mat_insuf, data = radios_delitos_l)

summary(model)


## ---- highlight=TRUE, prompt=TRUE, strip.white=FALSE, collapse=TRUE, tidy=TRUE----
model<-lm(n_delitos ~ AREA_KM2*dist_seguridad, data=radios_delitos_l)
summary(model)

