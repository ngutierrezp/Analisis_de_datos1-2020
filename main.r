
dirstudio <- rstudioapi::getSourceEditorContext()$path


if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")



all.df <- getAllData()