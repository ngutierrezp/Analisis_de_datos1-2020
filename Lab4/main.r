
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


sum.first.tree <- summary(first.tree)

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
matrix <- caret::confusionMatrix(pre.matriz)



# Estudio de modelo
# ------------------

# De la matrix de confusión se puede obtener lo siguiente :

# El acurrancy es cerca del 81%, si bien no es un valor bajo
# tampoco es un valor muy alto como los obtenidos en el modelo de regresión.

# Otro punto importante a destacar es la significancia que tuvo las pruebas
#  de binom.test y mcnemar.test las cuales terminan siendo significativas (< 0.05)
# lo cual primero nos dice que los resultados del modelo fueron mucho mas 
# precisos que el NIR.

# Respecto al p-valor de mcnemar.test nos dice que no existen cambios
# entre el conjunto de test y lo predicho por el modelo, es decir, el acurrancy
# obtenido por el modelo no varia por el set de prueba lo cual para este caso es 
# bueno.



















####################################
# PARTE 2: Mejoramiento del Modelo
####################################


# Como estamos dentro de un problema que implica trabajar con pacientes con 
# posibles dolores al corazón, es importante realizar el mejor estudio posible
# debido a que predecir en un 81% de forma correcta si existe o no una enfermedad
# implica que en el peor de los casos el 19% de los pacientes podria morir si 
# el clasificador falla. Es por esto que necesitamos mejorarlo y tratar de 
# llegar un predictor óptimo.








#   Boosting
# ------------------------


# Primeramente al modelo antes obtenido le aplicaremos boosting para obtener
# un modelo del tipo ensemble.

# indicamos que queremos 8 iteraciones de boosting
boost.tree.c50 <- C5.0(disease ~ ., data = train.df, trials=14)




### 1.1  Generación de matriz de confución
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
# los datos ajustado son significativamente mayores al NIR. Respecto al Test
# de mcNemar, el p-valor tiende a ser mayor lo que nos dice que posiblemente
# con este nuevo modelo generado, exista un sobreajuste. 


# En resumen, el modelo generado por boosting es mucho mejor pero 
# posiblemente tenga algun grado de sobreajuste por lo que hay que tomar en 
# cuenta esto y ver si se puede resolver.








#   variables influyentes
# ------------------------

# Parte importante es analizar las variables más utilizadas y significativas en
# el modelo creado.

# Para ver que variables son las más influyentes en la predicción utilizaremos
# las metricas de :

# USAGE: Cuantos datos pasan por las variables. 
# SPLIT: Cuantas veces el predictor se divide.


# Utilizaremós el mejor modelo que tenemos por el momento que es el de boosting

## Metrica USAGE
imp_vars_usag <- C5imp(boost.tree.c50, metric = "usage")
imp_vars_usag <- imp_vars_usag %>%
  rownames_to_column(var = "predictor")

## METRICA SPLITS
imp_vars_spli <- C5imp(boost.tree.c50, metric = "splits")
imp_vars_spli <- imp_vars_spli  %>%
  rownames_to_column(var = "predictor")



# Utilicemos un grafico para mostrar el comportamiento de las variables:

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


# Este algormitmo nos dirá que tan importantes son las variables.
# Volveremos a general el arbol de boosting pero ahora estudiando las 
# variables.

boost.tree.c50.vars <- C5.0(disease ~ ., data = train.df, trials=14,
                            control= C5.0Control(winnow = T))




### 2.2 Conclusión Variables importantes :
#######

# Según las metricas, la variable con mayor importancia es la edad luego, el tipo
# de dolor de pecho que sienta una persona (cp) y el sexo que tenga esa persona.

# Pero la variable que tiende a importar menos es Chol, es decir, si una
# persona tiene el colesteror estable o no. 

# Si se analiza la variable Chol, se puede ver que esta posee una cantidad 
# importante de NA´s (202). Podemos ver que más del 89% de los pacientes con
# esta variable presentan anomalias en el colesterol. Recordemos que un 
# colesterol normal es menor a 200 mg/dL. Entonces perfectamente podemos 
# sacar esta variable ya que no nos da información importante
# ya que la gran mayoria de los pacientes tiene un colesterol alto.

# Con el algoritmo de Winnowing 3 Variables fueron eliminadas dejando
# las más importantes como : age, sex, cp, exang, fbs, thalach, restecg.
#                            (1)  (2) (3)   (9)   (6)      (8)    (7)














####################################
# PARTE 3: Modelo Final
####################################

# Con el estudio realizado a los modelos anteriores ya podemos generar
# el mejor Álbol de desición posible.

# DF con las variables importantes.
imp.var.df <- factor.all.df[,c(1,2,3,6,7,8,9,11)]




### Generamos unos nuevos set de entrenamiento y prueba.

set.seed(985426)


ntrain.imp <- nrow(imp.var.df) * 0.7

index_train.imp<-sample(1:nrow(imp.var.df),size = ntrain.imp)

imp.train.df<-imp.var.df[index_train.imp,]

imp.test.df<-imp.var.df[-index_train.imp,]



# Verificamos que la diferencia entre los set sea menor a un 5%.

imp.diference.df <- equal.train.test(imp.train.df,imp.test.df)

# Como es cerca del 3% podemos suponer que ambos set estan bien distribuidos.



### Generamos el arbol.
imp.boost.tree <- C5.0(disease ~ ., data = imp.train.df, trials=18)


### Generamos la matriz de confusión para comprobar metricas

imp.predic.boost.tree <- predict(imp.boost.tree, imp.test.df[,-8], type = "class")

# pre-matriz con los datos tabulados
imp.pre.boost.matriz <- table(imp.test.df$disease, imp.predic.boost.tree)

# matriz de confusión
imp.boost.matrix <- caret::confusionMatrix(imp.pre.boost.matriz)

plot(imp.boost.tree)

###
## Analisis

# El árbol obtenido producto de la fase de mejoramiento realmente resulto ser
# mucho mejor a los anteriores debido a que si bien el acurrancy no mejoró mucho
# respecto al arbol anterior, un 1% puede dar la diferencia y de todas formas
# ayuda de sobremanera. La exactitud del arbol sigue siendo significativa
# respecto al NIR debido a que el p-valor es de 2*e^(-16). 
# Respecto al p-Valor de Macnemar, si bien este no es significativo ha bajado
# y se encuentra casi al limite lo que da indición que existe un sobreajuste
# pero este es leve por lo que si bien afecta al modelo, no lo hace 
# con tanta fuerza. Recordemos que este último test no es del todo preciso ya
# que depende de los datos por lo que sus valors pueden variar con otros.


# En sistesis se ha creado un buen modelo el que hay que comparar con 
# otros modelo obtenidos por otros metodos. 


