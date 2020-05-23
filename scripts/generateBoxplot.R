
showBoxplot <- function(numerical.health,numerical.sick){
  age.health <- numerical.health$age
  age.sick <- numerical.sick$age
  
  boxplot(age.health,age.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Age Comparison",
          xlab = "Pacients",
          ylab = "age")
  
  trestbps.health <- numerical.health$trestbps
  trestbps.sick <- numerical.sick$trestbps
  
  boxplot(trestbps.health,trestbps.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Trestbps Comparison",
          xlab = "Pacients",
          ylab = "age")
  
  chol.health <- numerical.health$chol
  chol.sick <- numerical.sick$chol
  
  boxplot(chol.health,chol.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Chol Comparison",
          xlab = "Pacients",
          ylab = "age")

  thalach.health <- numerical.health$thalach
  thalach.sick <- numerical.sick$thalach
  
  boxplot(thalach.health,thalach.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Thalach Comparison",
          xlab = "Pacients",
          ylab = "age")
  
  oldpeak.health <- numerical.health$oldpeak
  oldpeak.sick <- numerical.sick$oldpeak
  
  boxplot(oldpeak.health,oldpeak.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Oldpeak Comparison",
          xlab = "Pacients",
          ylab = "age")
  
  ca.health <- numerical.health$ca
  ca.sick <- numerical.sick$ca
  
  boxplot(ca.health,ca.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Ca Comparison",
          xlab = "Pacients",
          ylab = "age")
  
}