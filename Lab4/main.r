
###################################
#     Paquetes utilizados:        #


#install.packages("ggpubr")
#install.packages("ggplot2")
#install.packages("C50")
#install.packages("caret")

library(ggpubr)
library(ggplot2)
library(C50)
library(caret)



###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")

if(!exists("discretize.Data", mode="function")) source("scripts/discretize.R")

if(!exists(c("filterItemSet","filterRules"), mode="function")) source("scripts/filter.R")

#############################
# LAB 4: ARBOLES DE DECISIÓN
############################

# En este laboratorio se estudiará y aplicará la teoria de clasificaicón
# sobre los arboles de decisión. Para esto se debe tener en cuenta que 
# los arboles de decisión se pueden dividir en dos grupos

# ARBOLES DE REGRESIÓN


# ARBOLES DE CLASIFICACIÓN.


# Este último es el que se utilizará debido a que la variable de respuesta
# o clase es una variable categorica de dos niveles.


## Para utilizar estos arboles se necesita encontrar los nodos mas puros
# u homogenios que nos permitan separar de buena forma la elección
# de una clase.


### CROSS ENTROPY ###
# Para encontrar los nodos más puros utilizaremos CROSS ENTROPY la cual
# está implementada en el algoritmo c5.0 del paquete C50. La entropia nos dice
# que tan desordenado se encuentra un sistema. En el caso particular de arboles
# nos dirá que tanta impureza tiene un nodo.  Si un nodo es puro, contiene 
# únicamente observaciones de una clase, su entropía es cero. 
# Por el contrario, si la frecuencia de cada clase es la misma, el valor de 
# la entropía alcanza el valor máximo de 1.





# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la informaciï¿½n del dataset
#               incluida la informaciï¿½n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- suppressWarnings(getAllData())

#######################


