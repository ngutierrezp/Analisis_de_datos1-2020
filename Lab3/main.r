
###################################
#     Paquetes utilizados:        #

#install.packages("arulesViz")
#install.packages("ggpubr")
#install.packages("ggplot2")

library(ggpubr)
library(ggplot2)
library(arulesViz)



###################################

## Apartado para fijar el workspace en Rstudio
dirstudio <- dirname(rstudioapi::getSourceEditorContext()$path)

setwd(dirstudio) 

if(!exists("getAllData", mode="function")) source("scripts/genereteProccessed.R")

if(!exists("discretizeData", mode="function")) source("scripts/discretize.R")






# Estructura del main

#################
# DATOS LIMPIOS #
#################



#     all.df :  Contiene toda la informaciï¿½n del dataset
#               incluida la informaciï¿½n del lugar de donde
#               fueron obtenidos (cleve,swit,hung,va)
all.df <- getAllData()

#######################
# Obtención de reglas #
#######################


# Antes de encontrar las reglas de asociación del data set, es importante
# tener en cuenta que primeramente se necesita un listado de transacciones.

# El objeto transacciones solo maneja información BOOLEANA por lo que es
# necesario transformar todos los datos a una forma booleana.

# Teniendo esto en cuenta un listado de transacciones debe estar en una
# cesta (basket).


### 1.- Generación de la cesta (basket)

# Para obtener la cesta primero se deben discretizar los datos.

basket <- discretizeData(all.df)


### 2.- Obtención de listado de transacciones

transactions <- as(basket, "transactions")
# de estas se puede sacar información util sobre cuantas variables tienen 
# los pacientes.

size.pacients <- size(transactions)


pacientes.quintile <-quantile(size.pacients, probs = seq(0,1,0.1))
#de esto se puede ver que el 70% de los pacientes tiene como maximo 14
# caracteristicas, es decir que cerca del 30% tiene todas las carcteristicas


### 3.- Obtención items más frecuentes

item.freq.por <- itemFrequency(x = transactions, type = "relative") %>% 
                  sort(decreasing = TRUE) 

item.freq <- itemFrequency(x = transactions, type = "absolute") %>% 
                  sort(decreasing = TRUE) 

### 4.- Obtención de items set mas frecuentes

support <- 30 / dim(transactions)[1]

itemsets <- apriori(data = transactions,
                    parameter = list(support = support,
                                     minlen = 1,
                                     maxlen = 14,
                                     maxtime = 10,
                                     target = "frequent itemset"))

# De esto se puede ver la función pudo encontrar 21.997 itemset frecuentes
# sin embargo este valor es demasiado elevado.



