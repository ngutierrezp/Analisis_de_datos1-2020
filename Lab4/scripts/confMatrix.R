conf.matrix <- function(train, test) {
  
  tp<-sum(data$num==1 & clusters==1)
  tn<-sum(data$num==0 & clusters==0)
  fp<-sum(data$num==0 & clusters==1)
  fn<-sum(data$num==1 & clusters==0)
  
  predicted.Enfermos <- c(tp,fp,sum(tp,fp)) 
  predicted.Sanos <- c(fn,tn,sum(fn,tn))
  totales <- c(sum(tp,fn),sum(fp,tn),sum(sum(tp,fn),sum(fp,tn)))
  
  matrixConf <- data.frame(predicted.Enfermos,predicted.Sanos,totales)
  row.names(matrixConf) <- c("real.enfermos","real.sanos","total")
  
  total <- sum(sum(tp,fn),sum(fp,tn))
  
  acurracy <- (tp+tn)/total
  miss.rate <- (fp+fn)/total
  sensivity <- tp/sum(data$num==1)
  especificity <- tn/sum(data$num==0)
  presicion <- tp/sum(clusters==1)
  vpn <- tn/sum(clusters==0)
  
  valores <- data.frame(acurracy,miss.rate,sensivity,especificity,presicion,vpn)
  
  return(list(matrixConf=matrixConf,list=valores)) 
}


equal.train.test <- function(train.df,test.df){
  
  train <- as.data.frame(table(train.df$disease)/nrow(train.df))
  names(train)[names(train) == 'Freq'] <- 'Train'
  
  test <- as.data.frame(table(test.df$disease)/nrow(test.df))
  names(test)[names(test) == 'Freq'] <- 'Test'
  test <- test$Test
  
  df <- data.frame(train,test)
  names(df)[names(df) == 'Var1'] <- ''
  df$Diference <- abs(df$Train - df$test)
  
  
  return(df)
  
}

