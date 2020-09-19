
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
# LAB 4: ARBOLES DE DECISI�N
############################

# En este laboratorio se estudiar� y aplicar� la teoria de clasificaic�n
# sobre los arboles de decisi�n. Para esto se debe tener en cuenta que 
# los arboles de decisi�n se pueden dividir en dos grupos

# ARBOLES DE REGRESI�N


# ARBOLES DE CLASIFICACI�N.


# Este �ltimo es el que se utilizar� debido a que la variable de respuesta
# o clase es una variable categorica de dos niveles.


## Para utilizar estos arboles se necesita encontrar los nodos mas puros
# u homogenios que nos permitan separar de buena forma la elecci�n
# de una clase.


### CROSS ENTROPY ###
# Para encontrar los nodos m�s puros utilizaremos CROSS ENTROPY la cual
# est� implementada en el algoritmo c5.0 del paquete C50. La entropia nos dice
# que tan desordenado se encuentra un sistema. En el caso particular de arboles
# nos dir� que tanta impureza tiene un nodo.  Si un nodo es puro, contiene 
# �nicamente observaciones de una clase, su entrop�a es cero. 
# Por el contrario, si la frecuencia de cada clase es la misma, el valor de 
# la entrop�a alcanza el valor m�ximo de 1.





# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la informaci�n del dataset
#               incluida la informaci�n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- suppressWarnings(getAllData())

#######################


