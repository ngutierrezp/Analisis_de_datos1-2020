


normal.test.2df <- function(df.group1,df.group2){
  
  # puesto que no se conoce el como se realizo la toma de muestras
  # ademas de que solo se puede esperar a que hayan sido al azar
  # solo podemos suporner una independencia de los elementos.
  
  
  
  
  # para saber que prueba utilizar, primeramente se necesita saber
  # si las muestas siguen una distribución normal. Para ello
  # se debe utilizar shapiro.test
  
  
  
  ###############
  # Analisis primer Grupo
  
  # lista con los resultados del shapiro.test 
  result.group1 <- lapply(df.group1, shapiro.test)
  
  
  result1.sapply <- sapply(result.group1  , '[', c("statistic","p.value"))
  
  df.group1 <- as.data.frame(t(result1.sapply))
  
  df.group1 <- cbind(names = rownames(df.group1), df.group1)
  rownames(df.group1) <- NULL
  
  ###############
  # Analisis segundo Grupo
  
  
  
  # lista con los resultados del shapiro.test 
  result.group2 <- lapply(df.group2, shapiro.test)
  
  
  result2.sapply <- sapply(result.group2  , '[', c("statistic","p.value"))
  
  df.group2 <- as.data.frame(t(result2.sapply))
  
  df.group2 <- cbind(names = rownames(df.group2), df.group2)
  rownames(df.group2) <- NULL
  
  return(list(df.group1,df.group2))
  
  
}