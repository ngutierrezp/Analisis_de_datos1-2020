
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
# sobre los arboles de decisión. Para esto 





# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la informaciï¿½n del dataset
#               incluida la informaciï¿½n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- suppressWarnings(getAllData())

#######################


