## ------------------------------------------------------------------------
library(tidyverse)
library(sf)
library(lubridate)


## ---- echo=TRUE----------------------------------------------------------
delitos <- read.csv("../data/delitos.csv")
delitos <- delitos %>%
                sample_n(5000)


## ----echo=TRUE-----------------------------------------------------------
f <- filter(delitos, 
            comuna=='Comuna 6' | comuna=='Comuna 10')
head(f)


## ---- echo=TRUE----------------------------------------------------------
filter(delitos, month(ymd(fecha)) == 1 | month(ymd(fecha)) == 12)


## ---- echo=TRUE----------------------------------------------------------
filter(delitos, month(ymd(fecha)) %in% c(1,12))


## ---- echo=TRUE----------------------------------------------------------
filter(delitos, !(comuna=='Comuna 6' | month(ymd(fecha)) > 3))
filter(delitos, (!comuna=='Comuna 6' & !month(ymd(fecha)) > 3))


## ---- echo=TRUE----------------------------------------------------------
x <- NA
y <- NA

x == y


## ---- echo=TRUE----------------------------------------------------------
is.na(x)


## ---- echo=TRUE----------------------------------------------------------
df <- data.frame(x = c(1, NA, 3))

filter(df, x > 1)

filter(df, x > 1 | is.na(x))


## ---- echo=TRUE----------------------------------------------------------
f<-arrange(delitos, comuna, ymd(fecha), hms(hora))
head(f)


## ----echo=TRUE-----------------------------------------------------------
f<-arrange(delitos, comuna, desc(ymd(fecha)), desc(hms(hora)))
head(f)


## ---- echo=TRUE----------------------------------------------------------
f<-select(delitos, comuna, barrio, tipo_delito) # Selección por nombre
head(f)

f<-select(delitos, comuna:fecha) # Selección por rango de nombres
head(f)

f<-select(delitos, -(comuna:fecha)) # Selección de todas las columnas excepto las que están en el rango de nombres
head(f)


## ---- echo=TRUE----------------------------------------------------------
f<-select(delitos, comuna, barrio, tipo_delito, everything())
head(f)


## ---- echo=TRUE----------------------------------------------------------
head(rename(delitos, COMUNA=comuna))


## ---- echo=TRUE----------------------------------------------------------
f<-mutate(delitos, 
          hora_simple = hour(hms(hora)),
          dia=day(ymd(fecha)),
          mes=month(ymd(fecha)),
          year=year(ymd(fecha)))
head(f)


## ---- echo=TRUE----------------------------------------------------------
f<-group_by(delitos, f=month(ymd(fecha), label=TRUE))
summarize(f, delay=n())

