library(data.table)

getAnalysis <- function(numerical.df){
  data.age <- c(summary(numerical.df$age),0)
  data.trestbps <- c(summary(numerical.df$trestbps))
  data.chol <- c(summary(numerical.df$chol))
  data.thalach <- c(summary(numerical.df$thalach))
  data.oldpeak <- c(summary(numerical.df$oldpeak))
  data.ca <- c(summary(numerical.df$ca))
  
  var.age <- var(numerical.df$age,na.rm = TRUE)
  var.trestbps <- var(numerical.df$trestbps, na.rm = TRUE)
  var.chol <- var(numerical.df$chol,na.rm = TRUE)
  var.thalach <- var(numerical.df$thalach, na.rm = TRUE)
  var.oldpeak <- var(numerical.df$oldpeak, na.rm = TRUE)
  var.ca <- var(numerical.df$ca, na.rm = TRUE)
  
  var.list <- c(var.age,var.trestbps,var.chol,var.thalach,var.oldpeak,var.ca)
  
  
  df <- data.frame(age = data.age,
                   trestbos = data.trestbps,
                   chol = data.chol,
                   thalach = data.thalach,
                   oldpeak = data.oldpeak,
                   ca = data.ca
                   )
  df[nrow(df) + 1,] = var.list
  
  setattr(df, "row.names", c("Min","1st Qu.","Median","Mean","3rd Qu.","Max","NAs","Var"))

  
  return(df)
}