###################################
#     Paquetes utilizados:        #

#install.packages("tidyverse")
#install.packages("C50")
#install.packages("caret")
#install.packages("tree")
#install.packages("ggpubr")


library(tidyverse)
library(C50)
library(tree)
library(caret)
library(ggpubr)
library(ROCR)


###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")

if(!exists(c("filterItemSet","filterRules"), mode="function")) source("scripts/confMatrix.R")

#############################
# LAB 4: ARBOLES DE DECISIÓN
############################

# En este laboratorio se estudiará y aplicará la teoría de clasificación
# sobre los árboles de decisión. Para esto se debe tener en cuenta que 
# los árboles de decisión se pueden dividir en dos grupos

# ARBOLES DE REGRESIÓN


# ARBOLES DE CLASIFICACIÓN.


# Este último es el que se utilizará debido a que la variable de respuesta
# o clase es una variable categórica de dos niveles.


## Para utilizar estos árboles se necesita encontrar los nodos más puros
# u homogéneos que nos permitan separar de buena forma la elección
# de una clase.


### CROSS ENTROPY ###
# Para encontrar los nodos más puros utilizaremos CROSS ENTROPY la cual
# está implementada en el algoritmo c5.0 del paquete C50. La entropía nos dice
# que tan desordenado se encuentra un sistema. En el caso particular de arboles
# nos dirá que tanta impureza tiene un nodo.  Si un nodo es puro, contiene 
# únicamente observaciones de una clase, su entropía es cero. 
# Por el contrario, si la frecuencia de cada clase es la misma, el valor de 
# la entropía alcanza el valor máximo de 1.



### PROCESO DE CREACIÓN DE UN ARBOL ###
# sin importan que método se haya utilizado para escoger el divisor de nodos
# la creación de un árbol sigue los siguientes pasos:

# 1. Para cada división de un nodo se calcula el valor de la medida utilizada.
# 2. Se pondera la pureza de la división por el % de datos presente en la 
# división respecto al número total de datos.
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



# Como ya tenemos los datos, generaremos un primer árbol con todas las variables
# estudiando la variable de respuesta num:

# num : 1 -> Paciente enfermo
# num : 0 -> Paciente Sano


### ALGORITMO C5.0:

# El algoritmo C5.0 permite crear arboles de clasificación, se caracteriza por :

#   1.- Utiliza modelos de reglas basados en boosting
#   2.- Utiliza una medida de pureza por entropía.
#   3.- Poda las ramas del árbol por medio de pessimistic pruning
#   4.- Utiliza una estrategia de selección de predictores antes de cada ajuste.
#   5.- Aplica un algoritmo de boosting : AdaBoost
#   6.- Asigna diferente peso a cada tipo de error.



## Primeramente veamos cómo se comporta un árbol con todas las variables

first.tree <- tree(num ~ ., all.df[,-15])


sum.first.tree <- summary(first.tree)

## Si se ve cómo se comporta el primer árbol podemos ver que posee una
# promedio de desviación del 9% aproximadamente. La idea es que ese % sea lo
# menor posible. También se puede que este árbol posee 13 nodos terminales, por
# lo que si vemos como es el árbol generado se tiene : 

plot(x = first.tree, type = "proportional")
text(x = first.tree, splits = TRUE, pretty = 0,
     cex = 0.7, col = "firebrick")


# Del grafico se puede ver que las variables más influyentes en la predicción
# son thal, ca, cp.

# sin embargo de los laboratorios anteriores se sabe que thal y ca poseen
# gran número de NA´s lo que implica que los valores que toman estas variables
# son engañosos y no reflejan la realidad de los pacientes.




# tenemos que tener en cuenta que este primer árbol generado no es del todo
# certero ya que estamos utilizando todos los datos del dataset por lo que
# existe el peligro de que el modelo se esté sobre ajustando. Como primera
# aproximación nos sirve para ver sus comportamiento pero no se puede 
# establecer apriori como una solución.



# Otro error que se puede detectar si se ingresan los datos tal cual, es que
# todos de ellos son numéricos. Los árboles también aceptan variables cualitativas
# por lo que es posible darles variables con la interpretación adecuada como
# factor.


mixed.all.df <- getMixedData(all.df)
factor.all.df <- mixed.all.df %>% map_if(.p = is_character, .f = as.factor) %>%
  as.data.frame()


# Como ahora ya se trabaja en factores, se pueden sacar las variables con más
# NA´s vistos de los laboratorios anteriores.

factor.all.df <- factor.all.df[,-c(11,12,13,15)] 




############################
# Arbol con algoritmo C5.0


# Para este algoritmo se dividirá la totalidad de los datos en 70% para
# el entrenamiento y 30% para el test del modelo.

set.seed(18615)

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

## Generación del Árbol
arbol.c50 <- C5.0(disease ~ ., data = train.df)


##Plot del árbol
plot.arbolC50 <- plot(arbol.c50)


## Reglas del árbol
rules.arbol.c50 <- C5.0(x = train.df[, -11], y = train.df$disease, rules = T)






#  Generación de matriz de confusión
# ------------------------------------

# Generación de datos de prueba respecto al set de entrenamiento.
predic.arbolC50 <- predict(arbol.c50, test.df[,-11], type = "class")

# pre-matriz con los datos tabulados
pre.matriz <- table(test.df$disease, predic.arbolC50)

# matriz de confusión
matrix <- caret::confusionMatrix(pre.matriz)



# Estudio de modelo
# ------------------

# De la matriz de confusión se puede obtener lo siguiente :

# El acurrancy es cerca del 81%, si bien no es un valor bajo
# tampoco es un valor muy alto como los obtenidos en el modelo de regresión.

# Otro punto importante a destacar es la significancia que tuvo las pruebas
#  de binom.test y mcnemar.test las cuales terminan siendo significativas (< 0.05)
# lo cual primero nos dice que los resultados del modelo fueron mucho mas 
# precisos que el NIR.

# Respecto al p-valor de mcnemar.test nos dice que no existen cambios
# entre el conjunto de prueba y lo predicho por el modelo, es decir, el acurrancy
# obtenido por el modelo no varia por el set de prueba lo cual para este caso es 
# bueno.



















####################################
# PARTE 2: Mejoramiento del Modelo
####################################


# Como estamos dentro de un problema que implica trabajar con pacientes con 
# posibles dolores al corazón, es importante realizar el mejor estudio posible
# debido a que predecir en un 81% de forma correcta si existe o no una enfermedad
# implica que en el peor de los casos el 19% de los pacientes podría morir si 
# el clasificador falla. Es por esto que necesitamos mejorarlo y tratar de 
# llegar un predictor óptimo.








#   Boosting
# ------------------------


# Primeramente al modelo antes obtenido le aplicaremos boosting para obtener
# un modelo del tipo ensemble.

# indicamos que queremos 8 iteraciones de boosting
boost.tree.c50 <- C5.0(disease ~ ., data = train.df, trials=14)




### 1.1 Generación de matriz de confusión
########

# Generación de datos de prueba respecto al set de entrenamiento.
predic.boost.tree <- predict(boost.tree.c50, test.df[,-11], type = "class")

# pre-matriz con los datos tabulados
pre.boost.matriz <- table(test.df$disease, predic.boost.tree)

# matriz de confusión
boost.matrix <- caret::confusionMatrix(pre.boost.matriz)


### 1.2 Conclusión Boosting :
#######

# Como se puede ver en los resultados de la matriz de confusión, se obtuvo una
# mejora en el accurancy además de la sensibilidad y especificidad lo cual
# son buenos indicadores. Respecto al P-value, nos sigue diciendo que 
# los datos ajustados son significativamente mayores al NIR. Respecto al Test
# de mcNemar, el p-valor tiende a ser mayor lo que nos dice que posiblemente
# con este nuevo modelo generado, exista un sobreajuste. 


# En resumen, el modelo generado por boosting es mucho mejor pero 
# posiblemente tenga algún grado de sobreajuste por lo que hay que tomar en 
# cuenta esto y ver si se puede resolver.








#   variables influyentes
# ------------------------

# Parte importante es analizar las variables más utilizadas y significativas en
# el modelo creado.

# Para ver que variables son las más influyentes en la predicción utilizaremos
# las métricas de :

# USAGE: Cuantos datos pasan por las variables. 
# SPLIT: Cuantas veces el predictor se divide.


# Utilizaremos el mejor modelo que tenemos por el momento que es el de boosting

## Métrica USAGE
imp_vars_usag <- C5imp(boost.tree.c50, metric = "usage")
imp_vars_usag <- imp_vars_usag %>%
  rownames_to_column(var = "predictor")

## METRICA SPLITS
imp_vars_spli <- C5imp(boost.tree.c50, metric = "splits")
imp_vars_spli <- imp_vars_spli  %>%
  rownames_to_column(var = "predictor")



# Utilicemos un gráfico para mostrar el comportamiento de las variables:

plot.usage <- ggplot(data = imp_vars_usag, aes(x = reorder(predictor, Overall),
                                               y = Overall, fill = Overall)) +
  labs(x = "predictor", title = "usage") +
  geom_col() +
  coord_flip() +
  theme_bw() +
  theme(legend.position = "bottom")

plot.split <- ggplot(data = imp_vars_spli, aes(x = reorder(predictor, Overall),
                                               y = Overall, fill = Overall)) +
  labs(x = "predictor", title = "splits") +
  geom_col() +
  coord_flip() +
  theme_bw() +
  theme(legend.position = "bottom")


metric.plot <-ggarrange(plot.usage, plot.split)






### 2.1 Generación de Árbol con Winnowing 
#######


# Este algoritmo nos dirá que tan importantes son las variables.
# Volveremos a general el árbol de boosting pero ahora estudiando las 
# variables.

boost.tree.c50.vars <- C5.0(disease ~ ., data = train.df, trials=14,
                            control= C5.0Control(winnow = T))




### 2.2 Conclusión Variables importantes :
#######

# Según las métricas, la variable con mayor importancia es la edad luego, el tipo
# de dolor de pecho que sienta una persona (cp) y el sexo que tenga esa persona.

# Pero la variable que tiende a importar menos es Chol, es decir, si una
# persona tiene el colesterol estable o no. 

# Si se analiza la variable Chol, se puede ver que esta posee una cantidad 
# importante de NA´s (202). Podemos ver que más del 89% de los pacientes con
# esta variable presenta anomalías en el colesterol. Recordemos que un 
# colesterol normal es menor a 200 mg/dL. Entonces perfectamente podemos 
# sacar esta variable ya que no nos da información importante
# ya que la gran mayoría de los pacientes tiene un colesterol alto.

# Con el algoritmo de Winnowing 3 Variables fueron eliminadas dejando
# las más importantes como : age, sex, cp, exang, fbs, thalach, restecg.
#                            (1)  (2) (3)   (9)   (6)      (8)    (7)














####################################
# PARTE 3: Modelo Final
####################################

# Con el estudio realizado a los modelos anteriores ya podemos generar
# el mejor Árbol de decisión posible.

# DF con las variables importantes.
imp.var.df <- factor.all.df[,c(1,2,3,6,7,8,9,11)]




### Generamos unos nuevos sets de entrenamiento y prueba.

set.seed(985426)


ntrain.imp <- nrow(imp.var.df) * 0.7

index_train.imp<-sample(1:nrow(imp.var.df),size = ntrain.imp)

imp.train.df<-imp.var.df[index_train.imp,]

imp.test.df<-imp.var.df[-index_train.imp,]



# Verificamos que la diferencia entre los sets sea menor a un 5%.

imp.diference.df <- equal.train.test(imp.train.df,imp.test.df)

# Como es cerca del 3% podemos suponer que ambos sets están bien distribuidos.



### Generamos el arbol.
imp.boost.tree <- C5.0(disease ~ ., data = imp.train.df, trials=18)


### Generamos la matriz de confusión para comprobar métricas

imp.predic.boost.tree <- predict(imp.boost.tree, imp.test.df[,-8], type = "class")

# pre-matriz con los datos tabulados
imp.pre.boost.matriz <- table(imp.test.df$disease, imp.predic.boost.tree)

# matriz de confusión
imp.boost.matrix <- caret::confusionMatrix(imp.pre.boost.matriz)

plot(imp.boost.tree)


###
## Análisis

# El árbol obtenido producto de la fase de mejoramiento realmente resulto ser
# mucho mejor a los anteriores debido a que si bien el acurrancy no mejoró mucho
# respecto al árbol anterior, un 1% puede dar la diferencia y de todas formas
# ayuda de sobremanera. La exactitud del árbol sigue siendo significativa
# respecto al NIR debido a que el p-valor es de 2*e^(-16). 
# Respecto al p-Valor de Macnemar, si bien este no es significativo ha bajado
# y se encuentra casi al límite lo que da indició que existe un sobreajuste
# pero este es leve por lo que si bien afecta al modelo, no lo hace 
# con tanta fuerza. Recordemos que esta última prueba no es del todo preciso ya
# que depende de los datos por lo que sus valores pueden variar con otros.


# En síntesis se ha creado un buen modelo el que hay que comparar con 
# otros modelos obtenidos por otros métodos. 

imp.prediction <- prediction(as.numeric(imp.predic.boost.tree), as.numeric(imp.test.df$sex))
error.curve <- performance(imp.prediction,"tpr","fpr")

plot(error.curve)

## Obteniendo reglas del árbol :
rules.imp.boost.tree <- C5.0(disease ~ ., data = imp.train.df, trials=18,rules = T)
