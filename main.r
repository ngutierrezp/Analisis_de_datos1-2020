
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("showCorplot", mode="function")) source("scripts/corAnalysis.R")



all.df <- getAllData()

var.numerical <- c(1,4,5,8,10,12)

numerical.df <- all.df[var.numerical]

showCorplot(all.df,var.numerical)

## Analisis estadisticos con variables numericas

# Test estatico para dos grupos (sanos y enfermos) y comparar las diferentes medias
# para ver si hay alguna diferencia entre las medias de los grupos


# regresion logista probando diferentes variables contra el grupo de sanos o enfermos (dicotomica)