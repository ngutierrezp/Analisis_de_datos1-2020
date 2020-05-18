
showBoxplot <- function(numerical.loc){
  
  #Boxplot de age
  cleve.age <- numerical.df[numerical.loc$loc == "cleve",]$age
  switz.age <- numerical.df[numerical.loc$loc == "switz",]$age
  hung.age <- numerical.df[numerical.loc$loc == "hung",]$age
  va.age <- numerical.df[numerical.loc$loc == "va",]$age
  
  boxplot(cleve.age,switz.age,hung.age,va.age,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Age Comparison",
          xlab = "Location",
          ylab = "age")
  
  #Boxplot de trestbps
  cleve.trestbps <- numerical.df[numerical.loc$loc == "cleve",]$trestbps
  switz.trestbps <- numerical.df[numerical.loc$loc == "switz",]$trestbps
  hung.trestbps <- numerical.df[numerical.loc$loc == "hung",]$trestbps
  va.trestbps <- numerical.df[numerical.loc$loc == "va",]$trestbps
  
  boxplot(cleve.trestbps,switz.trestbps,hung.trestbps,va.trestbps,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Trestbps Comparison",
          xlab = "Location",
          ylab = "trestbps")
  
  #Boxplot de Chol
  cleve.chol <- numerical.df[numerical.loc$loc == "cleve",]$chol
  switz.chol <- numerical.df[numerical.loc$loc == "switz",]$chol
  hung.chol <- numerical.df[numerical.loc$loc == "hung",]$chol
  va.chol <- numerical.df[numerical.loc$loc == "va",]$chol
  
  boxplot(cleve.chol,switz.chol,hung.chol,va.chol,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Chol Comparison",
          xlab = "Location",
          ylab = "chol")
  
  #Boxplot de Thalach
  cleve.thalach <- numerical.df[numerical.loc$loc == "cleve",]$thalach
  switz.thalach <- numerical.df[numerical.loc$loc == "switz",]$thalach
  hung.thalach <- numerical.df[numerical.loc$loc == "hung",]$thalach
  va.thalach <- numerical.df[numerical.loc$loc == "va",]$thalach
  
  boxplot(cleve.thalach,switz.thalach,hung.thalach,va.thalach,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Thalach Comparison",
          xlab = "Location",
          ylab = "Thalach")
  
  #Boxplot de oldpeak
  cleve.oldpeak <- numerical.df[numerical.loc$loc == "cleve",]$oldpeak
  switz.oldpeak <- numerical.df[numerical.loc$loc == "switz",]$oldpeak
  hung.oldpeak <- numerical.df[numerical.loc$loc == "hung",]$oldpeak
  va.oldpeak <- numerical.df[numerical.loc$loc == "va",]$oldpeak
  
  boxplot(cleve.oldpeak,switz.oldpeak,hung.oldpeak,va.oldpeak,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Oldpeak Comparison",
          xlab = "Location",
          ylab = "oldpeak")
  
  #Boxplot de ca
  cleve.ca <- numerical.df[numerical.loc$loc == "cleve",]$ca
  switz.ca <- numerical.df[numerical.loc$loc == "switz",]$ca
  hung.ca <- numerical.df[numerical.loc$loc == "hung",]$ca
  va.ca <- numerical.df[numerical.loc$loc == "va",]$ca
  
  boxplot(cleve.ca,switz.ca,hung.ca,va.ca,
          names = c("cleve","switz","hung","va"),
          col = c("red","green","blue","yellow"),
          main = "Ca Comparison",
          xlab = "Location",
          ylab = "ca")
  
}