
my_summary <- function(v){
  if(!any(is.na(v))){
    res <- c(summary(v),"NA's"=0)
  } else{
    res <- summary(v)
  }
  return(res)
}

getAnalysisSH <- function(numerical.sh){
  age <- numerical.sh$age
  trestbps <- numerical.sh$trestbps
  chol <- numerical.sh$chol
  thalach <- numerical.sh$thalach
  oldpeak <- numerical.sh$thalach
  ca <- numerical.sh$ca
  
  var.age <- var(age,na.rm = TRUE)
  var.trestbps <- var(trestbps, na.rm = TRUE)
  var.chol <- var(chol,na.rm = TRUE)
  var.thalach <- var(thalach, na.rm = TRUE)
  var.oldpeak <- var(oldpeak, na.rm = TRUE)
  var.ca <- var(ca, na.rm = TRUE)
  
  sd.age <- sd(age,na.rm = TRUE)
  sd.trestbps <- sd(trestbps, na.rm = TRUE)
  sd.chol <- sd(chol,na.rm = TRUE)
  sd.thalach <- sd(thalach, na.rm = TRUE)
  sd.oldpeak <- sd(oldpeak, na.rm = TRUE)
  sd.ca <- sd(ca, na.rm = TRUE)
  
  data.age <- c(my_summary(age),"var"=var.age,"sd"=sd.age)
  data.trestbps <- c(my_summary(trestbps),"var"=var.trestbps,"sd"=sd.trestbps)
  data.chol <- c(my_summary(chol),"var"=var.chol,"sd"=sd.chol)
  data.thalach <- c(my_summary(thalach),"var"=var.thalach,"sd"=sd.thalach)
  data.oldpeak <- c(my_summary(oldpeak),"var"=var.oldpeak,"sd"=sd.oldpeak)
  data.ca <- c(my_summary(ca),"var"=var.ca,"sd"=sd.ca)
  
  df <- data.frame(age = data.age,
                   trestbps = data.trestbps,
                   chol = data.chol,
                   thalach = data.thalach,
                   oldpeak= data.oldpeak,
                   ca = data.ca
  )
  return(df)  
  
  
  
  
}