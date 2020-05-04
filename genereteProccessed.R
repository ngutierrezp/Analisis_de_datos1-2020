### Script para creación de una gran dataset

processed.headers = c("age","sex","cp","trestbps","chol","fbs","restecg","thalach","exang","oldpeak","slope","ca","thal","num")


## Dataset Cleveland 

cleveland <- read.table("processed.cleveland.data",header = F, sep = ",", col.names = processed.headers)

cleveland$loc <- rep("cleve", nrow(cleveland))

## Dataset hungarian 

hungarian <- read.table("processed.hungarian.data",header = F, sep = ",", col.names = processed.headers)

hungarian$loc <- rep("hung", nrow(hungarian))

## Dataset switzerland


switzerland <- read.table("processed.switzerland.data",header = F, sep = ",", col.names = processed.headers)

switzerland$loc <- rep("switz", nrow(switzerland))

## Dataset va


va <- read.table("processed.va.data",header = F, sep = ",", col.names = processed.headers)

va$loc <- rep("va", nrow(va))


all.df <- rbind(cleveland,hungarian,switzerland,va)


