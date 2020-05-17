

my_summary <- function(v){
  if(!any(is.na(v))){
    res <- c(summary(v),"NA's"=0)
  } else{
    res <- summary(v)
  }
  return(res)
}



getAnalysisLoc <- function(var.numerical.loc,name){
  age.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$age
  trestbps.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$trestbps
  chol.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$chol
  thalach.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$thalach
  oldpeak.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$oldpeak
  ca.loc <- var.numerical.loc[var.numerical.loc$loc == name,]$ca
  
  var.age <- var(age.loc,na.rm = TRUE)
  var.trestbps <- var(trestbps.loc, na.rm = TRUE)
  var.chol <- var(chol.loc,na.rm = TRUE)
  var.thalach <- var(thalach.loc, na.rm = TRUE)
  var.oldpeak <- var(oldpeak.loc, na.rm = TRUE)
  var.ca <- var(ca.loc, na.rm = TRUE)
  
  sd.age <- sd(age.loc,na.rm = TRUE)
  sd.trestbps <- sd(trestbps.loc, na.rm = TRUE)
  sd.chol <- sd(chol.loc,na.rm = TRUE)
  sd.thalach <- sd(thalach.loc, na.rm = TRUE)
  sd.oldpeak <- sd(oldpeak.loc, na.rm = TRUE)
  sd.ca <- sd(ca.loc, na.rm = TRUE)
  

  data.loc_age <- c(my_summary(age.loc),"var"=var.age,"sd"=sd.age)
  data.loc_trestbps <- c(my_summary(trestbps.loc),"var"=var.trestbps,"sd"=sd.trestbps)
  data.loc_chol <- c(my_summary(chol.loc),"var"=var.chol,"sd"=sd.chol)
  data.loc_thalach <- c(my_summary(thalach.loc),"var"=var.thalach,"sd"=sd.thalach)
  data.loc_oldpeak <- c(my_summary(oldpeak.loc),"var"=var.oldpeak,"sd"=sd.oldpeak)
  data.loc_ca <- c(my_summary(ca.loc),"var"=var.ca,"sd"=sd.ca)
  
  
  
  df <- data.frame(age = data.loc_age,
                   trestbps = data.loc_trestbps,
                   chol = data.loc_chol,
                   thalach = data.loc_thalach,
                   oldpeak= data.loc_oldpeak,
                   ca = data.loc_ca
                   )
  return(df)  
}