

getAnalysis <- function(numerical.df){
  var.age <- var(numerical.df$age,na.rm = TRUE)
  var.trestbps <- var(numerical.df$trestbps, na.rm = TRUE)
  var.chol <- var(numerical.df$chol,na.rm = TRUE)
  var.thalach <- var(numerical.df$thalach, na.rm = TRUE)
  var.oldpeak <- var(numerical.df$oldpeak, na.rm = TRUE)
  var.ca <- var(numerical.df$ca, na.rm = TRUE)
  
  sd.age <- sd(numerical.df$age,na.rm = TRUE)
  sd.trestbps <- sd(numerical.df$trestbps, na.rm = TRUE)
  sd.chol <- sd(numerical.df$chol,na.rm = TRUE)
  sd.thalach <- sd(numerical.df$thalach, na.rm = TRUE)
  sd.oldpeak <- sd(numerical.df$oldpeak, na.rm = TRUE)
  sd.ca <- sd(numerical.df$ca, na.rm = TRUE)
  
  data.age <- c(summary(numerical.df$age),"Na's"=0,"var"=var.age,"sd"=sd.age)
  data.trestbps <- c(summary(numerical.df$trestbps),"var"=var.trestbps,"sd"=sd.trestbps)
  data.chol <- c(summary(numerical.df$chol),"var"=var.chol,"sd"=sd.chol)
  data.thalach <- c(summary(numerical.df$thalach),"var"=var.thalach,"sd"=sd.thalach)
  data.oldpeak <- c(summary(numerical.df$oldpeak),"var"=var.oldpeak,"sd"=sd.oldpeak)
  data.ca <- c(summary(numerical.df$ca),"var"=var.ca,"sd"=sd.ca)
  
  
  df <- data.frame(age = data.age,
                   trestbos = data.trestbps,
                   chol = data.chol,
                   thalach = data.thalach,
                   oldpeak = data.oldpeak,
                   ca = data.ca
                   )

  
  return(df)
}