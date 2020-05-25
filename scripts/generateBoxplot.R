
showBoxplot <- function(numerical.health,numerical.sick){
  
  #En cada sección se obtienen las variables a graficar y 
  #finalmente se realiza el grafico de caja
  
  #Grafico de caja para edad
  age.health <- numerical.health$age
  age.sick <- numerical.sick$age
  
  boxplot(age.health,age.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Age Comparison",
          xlab = "Pacients",
          ylab = "age")
  
  #Gráfico de caja para trestbps
  trestbps.health <- numerical.health$trestbps
  trestbps.sick <- numerical.sick$trestbps
  
  boxplot(trestbps.health,trestbps.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Trestbps Comparison",
          xlab = "Pacients",
          ylab = "trestbps")
  
  #Gráfico de caja para chol
  chol.health <- numerical.health$chol
  chol.sick <- numerical.sick$chol
  
  boxplot(chol.health,chol.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Chol Comparison",
          xlab = "Pacients",
          ylab = "chol")

  #Gráfico de caja para thalach
  thalach.health <- numerical.health$thalach
  thalach.sick <- numerical.sick$thalach
  
  boxplot(thalach.health,thalach.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Thalach Comparison",
          xlab = "Pacients",
          ylab = "thalach")
  
  #Gráfico de caja para oldpeak
  oldpeak.health <- numerical.health$oldpeak
  oldpeak.sick <- numerical.sick$oldpeak
  
  boxplot(oldpeak.health,oldpeak.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Oldpeak Comparison",
          xlab = "Pacients",
          ylab = "oldpeak")
  
  #Gráfico de caja para ca
  ca.health <- numerical.health$ca
  ca.sick <- numerical.sick$ca
  
  boxplot(ca.health,ca.sick,
          names = c("health","sick"),
          col = c("red","green"),
          main = "Ca Comparison",
          xlab = "Pacients",
          ylab = "ca")
  
}