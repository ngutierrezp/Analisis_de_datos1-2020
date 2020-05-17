
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("showCorplot", mode="function")) source("scripts/corAnalysis.R")
if(!exists("getAnalysis", mode="function")) source("scripts/getAnalysis.R")
if(!exists("getAnalysisLoc", mode="function")) source("scripts/getAnalysisLoc.R")



all.df <- getAllData()

var.numerical <- c(1,4,5,8,10,12)

numerical.df <- all.df[var.numerical]

showCorplot(all.df,var.numerical)

var.numerical.loc <- c(1,4,5,8,10,12,15)
numerical.loc.df <- all.df[var.numerical.loc]

all.analysis <- getAnalysis(numerical.df)

cleve.analysis <- getAnalysisLoc(numerical.loc.df,"cleve")

hung.analysis <- getAnalysisLoc(numerical.loc.df,"hung")

switz.analysis <- getAnalysisLoc(numerical.loc.df,"switz")

va.analysis <- getAnalysisLoc(numerical.loc.df,"va")


## Analisis estadisticos con variables numericas

# Test estatico para dos grupos (sanos y enfermos) y comparar las diferentes medias
# para ver si hay alguna diferencia entre las medias de los grupos


# regresion logista probando diferentes variables contra el grupo de sanos o enfermos (dicotomica)