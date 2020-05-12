
dirstudio <- rstudioapi::getSourceEditorContext()$path

dir <- getwd()

setwd(dir)


if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("showCorplot", mode="function")) source("scripts/corAnalysis.R")



all.df <- getAllData()

showCorplot(all.df)