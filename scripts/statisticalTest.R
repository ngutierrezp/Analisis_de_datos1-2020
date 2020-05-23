


normal.test.2df <- function(df.group1,df.group2){
  
  # Puesto que no se conoce el como se realizo la toma de muestras
  # ademas de que solo se puede esperar a que hayan sido al azar
  # solo podemos suporner una independencia de los elementos.
  
  
  
  
  # Para saber que prueba utilizar, primeramente se necesita saber
  # si las muestas siguen una distribución normal. Para ello
  # se debe utilizar shapiro.test
  
  
  
  ######################
  # Analisis primer Grupo
  
  # lista con los resultados del shapiro.test 
  result.group1 <- lapply(df.group1, shapiro.test)
  
  
  result1.sapply <- sapply(result.group1  , '[', c("statistic","p.value"))
  
  df.group1 <- as.data.frame(t(result1.sapply))
  
  df.group1 <- cbind(names = rownames(df.group1), df.group1)
  rownames(df.group1) <- NULL
  
  #############################
  # Analisis segundo Grupo
  
  
  
  # lista con los resultados del shapiro.test 
  result.group2 <- lapply(df.group2, shapiro.test)
  
  
  result2.sapply <- sapply(result.group2  , '[', c("statistic","p.value"))
  
  df.group2 <- as.data.frame(t(result2.sapply))
  
  df.group2 <- cbind(names = rownames(df.group2), df.group2)
  rownames(df.group2) <- NULL
  
  return(list(df.group1,df.group2))
  
  
}



mann.whitney.2df.test <- function(df.group1, df.group2){
  
  
  # cuando no es posible utilizar la prueba t para variables
  # indepeendientes, ya que no cumplen un requisito de la prueba,
  # es posible utilizar la prueba de Mann-Whitney la cual 
  # no es parametrica ya que utiliza un rango para comparar
  # dos distribuciones
  
  
  # Comprobamos que las columnas sean iguales en ambos df
  if (sum(
        ifelse(names(df.group1) == names(df.group2) ,1 ,0)
         )
      == length(names(df.group1))
    )
  {
      
    result.groups <- lapply(1:length(names(df.group1)), function(x){
          wilcox.test(df.group1[,x],df.group2[,x],paired = FALSE)
        }
    )
    
    result.sapply <- sapply(result.groups  , '[', c("statistic","p.value"))
    
    df.groups <- as.data.frame(t(result.sapply))
    
    df.groups <- cbind(names = names(df.group1), df.groups)
    
    
    return(df.groups)
      
    
    
    
  }
  else{
    print("No se pudo aplicar Mann-Whitney ya que los df no tienen las mismas columnas")

  }
  
  
  
  
}