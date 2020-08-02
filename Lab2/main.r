
###################################
#     Paquetes utilizados:        #

#install.packages(ggplot2)
#install.packages("ggpubr")
#install.packages("scales")
#install.packages("VIM")
#install.packages("factoextra")

library(VIM)
library(ggpubr)
library(scales)
library(factoextra)
library(NbClust)
library(ggplot2)




###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")
if(!exists("renormalize.data.frame", mode="function")) source("scripts/normalization.R")
if(!exists("normalize.data.frame", mode="function")) source("scripts/normalization.R")
if(!exists("numCluster", mode="function")) source("scripts/getNumCluster.R")
if(!exists("conf.matrix ", mode="function")) source("scripts/confMatrix.R")





# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la informaci�n del dataset
#               incluida la informaci�n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- getAllData()





####################
# Preprocesamiento #
####################

# Para el pre-procesamiento antes de aplicar un cluster, es necesario 
# normalizar los datos numericos que tienden a ser muy atipicos
# Esta informaci�n se puede obtener del trabajo anterior 
# age, trestbps, chol, thalach, oldpeakyca y ca




### limpieza ### 
################

# Antes de proceder, es necesario quitar la clase ademas de las variables que no fueron significativas
# durante el primer estudio (consular primer Lab).

# De esta ultima tambien se decido quitar la variable slope la cual contiene demasiados NAs.

pre.normalized.df <- all.df[c(2,3,4,5,8,9,10)]


# Este df se utilizara luego para comparar
pre.normalized.df.with.class <- all.df[c(2,3,4,5,8,9,10,14)]





### normalizacion ###
#####################

# El algoritmo de k-means es muy sensible a outliers por lo que es necesario 
# normalizar todos los datos dentro de una misma escala. 

# Es importante destacar que sin importar el dato que se este utilizando
# la normalizacion se aplica a todas las observaciones por igual.

normalized.df <- normalize.data.frame(pre.normalized.df)






# Eliminaci�n de NA #
#####################

normalized.df.without.na <- na.omit(normalized.df)
normalized.df.wot.na.with.class <-  na.omit(pre.normalized.df.with.class)



### Obtencion del numero de clusters ###
########################################

# Como el algoritmo de k-means necesita que se especifique un numero de
# clusters o centros.

# Generalmente estos centros se condicen con la clase del dataset que se
# esta estudiando, sin embargo, no siempre se conoce la clase por lo que
# un analisis del numero de clusters termina tomando relevancia. 

# Para el caso particular de este dataset, el numero de centros debe ser 2.


n_cluster <- numCluster(normalized.df)

# segun el analisis, el mejor numero de cluster tambien es 2.





#################
# Procesamiento #
#################



# Distancia #
#############

# Al existir datos muy alejados aun cuando se ha normalizado, es importante 
# utilizar una distancia que sea robusta, por esto se ha escogido utilizar
# la distancia de manhattan.

distance.data <- dist(normalized.df.without.na, method = "manhattan")






# clustering #
##############
# El paso que sigue es la aplicaci�n del algoritmo de clustering.

# se establece un nstart en 40 debido a que determina el n�mero de veces que 
# se va a repetir el proceso, cada vez con una asignaci�n aleatoria inicial 
# distinta. Es recomendable que este �ltimo valor sea alto, entre 25-50, para 
# no obtener resultados malos debido a una iniciaci�n poco afortunada del proceso.

set.seed(78546)
clusters <- kmeans(distance.data, 2, nstart = 40, iter.max = 50)





# Visualizaci�n #
#################
# parte importante del proceso de clustering es la etapa de visualizacion
# donde se exponen los reultados.

# Como existen varias dimenciones dentro de las observaciones no es posible
# exponer todas en un mismo grafico. Es por esto que se necesitan obtener las
# principales.

# Es por esto que un analisis de componentes principales es util para este caso

# gracias a la funcion fviz_cluster, es posible esto ya despliega los datos
# en las componentes principales del dataset.

graph.cluster <-fviz_cluster(clusters, data = distance.data,pointsize = 2,)

# para este caso de desplegaron los datos en las componentes que explican el
# 51.9% + 20.3% de los datos, un 72.2% en total.



#########################
# Analisis de resultado #
#########################


# Al saberse la clase es posible saber cuanto error existe en el calculo del
# cluster. En general esto no se suele hacer ya que las observaciones no suelen
# tener la clase.

modi.cluster <- ifelse(clusters$cluster == 2,0,1)

### Metricas ###

#Se obtiene la matriz de confusion junto a sus datos 
matrix <- conf.matrix(modi.cluster,normalized.df.wot.na.with.class)

#Matriz de confusion
matrixCong <- matrix$matrixConf

#Datos del modelo
model.data <- matrix$list



# https://www.datacamp.com/community/tutorials/k-means-clustering-r?utm_source=adwords_ppc&utm_campaignid=1455363063&utm_adgroupid=65083631748&utm_device=c&utm_keyword=&utm_matchtype=b&utm_network=g&utm_adpostion=&utm_creative=332602034358&utm_targetid=aud-299261629574:dsa-429603003980&utm_loc_interest_ms=&utm_loc_physical_ms=1003322&gclid=CjwKCAjwlZf3BRABEiwA8Q0qqyt2o8HjGVyzoP_gs1tmD1rtRECuwEfNezCcooSfSpedRkTvdEbdiBoCm-MQAvD_BwE
# https://www.researchgate.net/publication/333816994_Prediction_of_Heart_Disease_by_Clustering_and_Classification_Techniques
# https://rpubs.com/Joaquin_AR/310338
# https://www.ugr.es/~gallardo/pdf/cluster-1.pdf
# 

