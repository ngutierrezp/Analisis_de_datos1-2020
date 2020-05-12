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
  
  
  all$age = as.interger(all$age)
  all$sex = as.interger(all$sex)
  all$cp = as.interger(all$cp)
  all$trestbps = as.interger(all$trestbps)
  all$chol = as.interger(all$chol)
  all$fbs = as.interger(all$fbs)
  all$restecg = as.interger(all$restecg)
  all$thalach = as.interger(all$thalach)
  all$exang = as.interger(all$exang)
  all$oldpeak = as.interger(all$oldpeak)
  all$slope = as.interger(all$slope)
  all$ca = as.interger(all$ca)
  all$thal = as.interger(all$thal)
  all$num = as.interger(all$num)
  
  
  
  
  return(all)
  
}



