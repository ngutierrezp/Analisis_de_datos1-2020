### Script para creación de una gran dataset



getAllData <- function() { 
  
  processed.headers = c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang","oldpeak","slope","ca","thal","num")
  
  
  ## Dataset Cleveland 
  
  cleveland <- read.table("data/processed.cleveland.data",header = F, sep = ",", col.names = processed.headers)
  
  cleveland$loc <- rep("cleve", nrow(cleveland))
  
  ## Dataset hungarian 
  
  hungarian <- read.table("data/processed.hungarian.data",header = F, sep = ",", col.names = processed.headers)
  
  hungarian$loc <- rep("hung", nrow(hungarian))
  
  ## Dataset switzerland
  
  
  switzerland <- read.table("data/processed.switzerland.data",header = F, sep = ",", col.names = processed.headers)
  
  
  switzerland$loc <- rep("switz", nrow(switzerland))
  
  ## Dataset va
  
  
  va <- read.table("data/processed.va.data",header = F, sep = ",", col.names = processed.headers)
  
  va$loc <- rep("va", nrow(va))
  
  all <-rbind(cleveland,hungarian,switzerland,va)
  
  
  all$age = as.integer(all$age)
  all$sex = as.integer(all$sex)
  all$cp = as.integer(all$cp)
  all$trestbps = as.integer(all$trestbps)
  all$chol = as.integer(all$chol)
  all$fbs = as.integer(all$fbs)
  all$restecg = as.integer(all$restecg)
  all$thalach = as.integer(all$thalach)
  all$exang = as.integer(all$exang)
  all$oldpeak = as.double(all$oldpeak)
  all$slope = as.integer(all$slope)
  all$ca = as.integer(all$ca)
  all$thal = as.integer(all$thal)
  all$num = as.integer(all$num)
  
  
  
  
  return(all)
  
}



