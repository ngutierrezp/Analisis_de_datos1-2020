
numCluster <- function(df){
  #Se omiten todos los NA's
  df_norm <- na.omit(df)
  
  NbClust(data=df_norm,distance="euclidean",min.nc=2,max.nc=15,method="kmeans")

}