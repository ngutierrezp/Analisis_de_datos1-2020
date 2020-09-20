
###################################
#     Paquetes utilizados:        #

#install.packages("tidyverse")
#install.packages("C50")
#install.packages("caret")
#install.packages("tree")


library(tidyverse)
library(C50)
library(caret)
library(tree)


###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")

if(!exists(c("filterItemSet","filterRules"), mode="function")) source("scripts/confMatrix.R")

#############################
# LAB 4: ARBOLES DE DECISIÓN
############################

# En este laboratorio se estudiará y aplicará la teoria de clasificaicón
# sobre los arboles de decisión. Para esto se debe tener en cuenta que 
# los arboles de decisión se pueden dividir en dos grupos

# ARBOLES DE REGRESIÓN


# ARBOLES DE CLASIFICACIÓN.


# Este último es el que se utilizará debido a que la variable de respuesta
# o clase es una variable categorica de dos niveles.


## Para utilizar estos arboles se necesita encontrar los nodos mas puros
# u homogenios que nos permitan separar de buena forma la elección
# de una clase.


### CROSS ENTROPY ###
# Para encontrar los nodos más puros utilizaremos CROSS ENTROPY la cual
# está implementada en el algoritmo c5.0 del paquete C50. La entropia nos dice
# que tan desordenado se encuentra un sistema. En el caso particular de arboles
# nos dirá que tanta impureza tiene un nodo.  Si un nodo es puro, contiene 
# únicamente observaciones de una clase, su entropía es cero. 
# Por el contrario, si la frecuencia de cada clase es la misma, el valor de 
# la entropía alcanza el valor máximo de 1.



### PROCESO DE CREACIÓN DE UN ARBOL ###
# sin importan que metodo se haya utilizado para escoger el dividor de nodos
# la creación de un arbol sigue los siguientes pasos:

# 1. Para cada división de un nodo se calcula el valor de la medida utilizada.
# 2. Se pondera la pureza de la división por el % de datos presente en la 
# división respecto al numero total de datos.
# 3. se escoge la mejor división respecto al valor calculado y se repite.







# Estructura del main

###################
# DATOS COMPLETOS #
###################



#     all.df :  Contiene toda la información del dataset
#               incluida la información del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- suppressWarnings(getAllData())


#######################






#################################
# PARTE 1: Generar Arbol
#################################



# Como ya tenemos los datos, generaremos un primer arbol con todas las variables
# estudiando la variable de respuesta num:

# num : 1 -> Paciente enfermo
# num : 0 -> Paciente Sano


### ALGORITMO C5.0:

# El algoritmo C5.0 permite crear arboles de clasificación, se caracteriza por :

#   1.- Utiliza modelos de reglas basados en boosting
#   2.- Utiliza una medida de pureza por entropia.
#   3.- Poda las ramas del arbol por medio de pessimistic pruning
#   4.- Utiliza una estrategia de selección de predictores antes de cada ajuste.
#   5.- Aplica un algoritmo de boosting : AdaBoost
#   6.- Asigna diferente peso a cada tipo de error.



## Primeramente veamos como se comporta un arbol con todas las variables

first.tree <- tree(num ~ ., all.df[,-15])


sum.first.tree <- summary(tree)

## Si se ve como se comporta el primer arbol podemos ver que posee una
# promedio de desviación del 9% aproximadamente. La idea es que ese % sea lo
# menor posible. Tambien se puede que este arbol posee 13 nodos terminales, por
# lo que si vemos como es el arbol generado se tiene : 

plot(x = first.tree, type = "proportional")
text(x = first.tree, splits = TRUE, pretty = 0,
     cex = 0.7, col = "firebrick")


# Del grafico se puede ver que las variables más influyentes en la predición
# son thal, ca, cp.

# sin emabargo de los laboratorios anteriores se sabe que thal y ca poseen
# gran numero de NA´s lo que implica que los valores que toman estas variables
# son engañosos y no reflejan la realidad de los pacientes.




# tenemos que tener en cuenta que este primer arbol generado no es del todo
# certero ya que estamos utilizando todos los datos del dataset por lo que
# existe el peligro de que el modelo se este sobreajustando. Como primera
# aproximación nos sirve para ver sus comportamiento pero no se puede 
# establecer apriori como una solución.



# Otro error que se puede detectar si se ingresan los datos tal cual, es que
# todos de ellos son numericos. Los arboles tambien aceptan variables cualitativas
# por lo que es posible darles variables con la interpretación adecuada como
# factor.


mixed.all.df <- getMixedData(all.df)
factor.all.df <- mixed.all.df %>% map_if(.p = is_character, .f = as.factor) %>%
        as.data.frame()


# Como ahora ya se trabaja en factores, se pueden sacar las varaibles con más
# NA´s vistos de los laboratorios anteriores.

factor.all.df <- factor.all.df[,-c(11,12,13,15)] 




############################
# Arbol con algoritmo C5.0


# Para este algoritmo se dividirá la totalidad de los datos en 70% para
# el entrenamiento y 30% para el test del modelo.

set.seed(985426)

ntrain <- nrow(factor.all.df) * 0.7

index_train<-sample(1:nrow(factor.all.df),size = ntrain)

train.df<-factor.all.df[index_train,]

test.df<-factor.all.df[-index_train,]


# Debemos comprobar se mantiene la misma proporción entre sano y enfermos
# entre las divisiones de entrenamiento y prueba.

diference.df <- equal.train.test(train.df,test.df)

# Vemos que para este caso la diferencia entre Train y Test es menos del 5%
# por lo que podemos proseguir con la generación del árbol.




#  Generación de Árbol con C5.0
# ------------------------------

## Generación del Arbol
arbol.c50 <- C5.0(disease ~ ., data = train.df)


##Plot del arbol
plot.arbolC50 <- plot(arbol.c50)


## Reglas del arbol
rules.arbol.c50 <- C5.0(x = train.df[, -11], y = train.df$disease, rules = T)






#  Generación de matriz de confución
# ------------------------------------

# Generación de datos de prueba respecto al set de entrenamiento.
predic.arbolC50 <- predict(arbol.c50, test.df[,-11], type = "class")

# pre-matriz con los datos tabulados
pre.matriz <- table(test.df$disease, predic.arbolC50)

# matriz de confusión
matrix <- confusionMatrix(pre.matriz)



# Estudio de modelo
# ------------------

# De la matrix de confusión se puede obtener lo siguiente :

# El acurrancy es cerca del 81%, si bien no es un valor bajo
# tampoco es un valor muy alto como los obtenidos en el modelo de regresión.

# 



