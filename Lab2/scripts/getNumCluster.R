
numCluster <- function(df){
  #Se omiten todos los NA's
  df_norm <- na.omit(df)
  
  #Se obtiene el número máximo de cluster por el método de la silueta.
  num_sil <- fviz_nbclust(df_norm,kmeans,method="silhouette")
  plot(num_sil)
  
  #Se obtiene el número máximo de cluster por el método del codo.
  num_cod <- fviz_nbclust(df_norm,kmeans,method="wss")
  plot(num_cod)
}