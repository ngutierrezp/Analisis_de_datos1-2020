
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("showCorplot", mode="function")) source("scripts/corAnalysis.R")
if(!exists("normal.test.2df", mode="function")) source("scripts/meanTest.R")
if(!exists("getAnalysis", mode="function")) source("scripts/getAnalysis.R")
if(!exists("getAnalysisLoc", mode="function")) source("scripts/getAnalysisLoc.R")


# df de todas las personas incluyendo sus localidades 
all.df <- getAllData()

var.numerical <- c(1,4,5,8,10,12)



numerical.df <- all.df[var.numerical]

showCorplot(all.df,var.numerical)

healthy <- all.df[all.df$num == 0,] # personas sin problemas al coraz�n
sick <- all.df[all.df$num > 0,] # personas con problemas al coraz�n



###############################################################
# Test de medias para dos grupos -> Sanos y enfermos
###############################################################


# df de las personas sin problemas de coraz�n con  solo las variables numericas
numerical.health <- healthy[var.numerical]  
# df de las personas con problemas de coraz�n con  solo las variables numericas
numerical.sick <- sick[var.numerical]

alpha <- 0.05

# lista de 2 df que contiene los p-valor para cada una de las variables
# numericas de los dos grupos a analizar
df.normal.result <- normal.test.2df(numerical.health,numerical.sick)


normal.dist.health <- df.normal.result[[1]]$names[df.normal.result[[1]]$p.value > alpha]

normal.dist.sick <- df.normal.result[[2]]$names[df.normal.result[[2]]$p.value > alpha]

# Como se puede ver ningun grupo comparte la normalidad en sus variables
# por lo que es necesario utilizar una prueba no parametrica

# Entonces una alternativa no parametrica para prueba de medias seria Mann-Whitney












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