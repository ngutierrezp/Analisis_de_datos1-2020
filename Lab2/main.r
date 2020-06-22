
###################################
#     Paquetes utilizados:        #

#install.packages(ggplot2)
#install.packages("ggpubr")
#install.packages("scales")
#install.packages("VIM")

library(VIM)
library(ggpubr)
library(ggmap)
library(scales)
library(factoextra)



###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("normalize.data.frame", mode="function")) source("scripts/normalization.R")
if(!exists("numCluster", mode="function")) source("scripts/getNumCluster.R")

# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la información del dataset
#               incluida la información del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- getAllData()


####################
# Preprocesamiento #
####################

# Para el pre-procesamiento antes de aplicar un cluster, es necesario 
# normalizar los datos numericos que tienden a ser muy atipicos
# Esta información se puede obtener del trabajo anterior 
# age, trestbps, chol, thalach, oldpeakyca y ca


## De estas variables numericas, no todas necesitan una normalización.
# Este es el caso de : age y ca 

normalized.df <- normalize.data.frame(all.df)

# Antes de proceder, es necesario quitar las clase ademas de las variables que no fueron significativas
# durante el primer estudio (consular primer Lab).

# De esta ultima tambien se decido quitar la variable slope la cual contiene demasiados NAs.

normalized.df <- normalized.df[c(2,3,4,5,8,9,10)]


#Se obtienen el numero maximo de cluster a través del método del codo y la silueta.

numCluster(normalized.df)

# Como se pueden ver los graficos, los numeros sugueridos de clusters termina siendo 10 sin embargo 
# el metodo del codo se puede ver que el numero sugerido es 3.


normalized.df.without.na <- na.omit(normalized.df)


clusters <- kmeans(normalized.df.without.na, 3)



# https://www.datacamp.com/community/tutorials/k-means-clustering-r?utm_source=adwords_ppc&utm_campaignid=1455363063&utm_adgroupid=65083631748&utm_device=c&utm_keyword=&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=332602034358&utm_targetid=aud-299261629574:dsa-429603003980&utm_loc_interest_ms=&utm_loc_physical_ms=1003322&gclid=CjwKCAjwlZf3BRABEiwA8Q0qqyt2o8HjGVyzoP_gs1tmD1rtRECuwEfNezCcooSfSpedRkTvdEbdiBoCm-MQAvD_BwE
