# Lab 1 Analisis de datos 1-2020: Análisis estadístico

A continuación se describe la parte del código realizado para el primer laboratorio programado de Analisis de Datos 1-2020.


## Objetivos :

- Identificar los distintos tipos de datos que se presenten en el Dataset.

- Identificar las clases presentes en el Dataset.

- Verificar relaciones existentes entre los atributos.

- Conocer comportamiento de la base de datos.

- Aplicar pruebas a los atributos del Dataset.

- Investigar sobre los diferentes estudios que se han realizado con los datos de la base dedatos.

## Resultados:

Al aplicar un Modelo de regresión Multiple sobre los datos para clasificar entre personas sanas o enfermas se obtuvo la siguiente matriz de confusición. 
**NOTA :** Para la creación del modelo se ha utilizado un 70% de los datos y el 30% restante se ha utilizado para la prueba del modelo.

|                     | Real Enfermos | Real Sanos | Total |
|---------------------|---------------|------------|-------|
| Predicción Enfermos | 103           | 16         | 119   |
| Predicción Sanos    | 16            | 54         | 70    |
| Total               | 119           | 70         | 189   |

Las metricas resultantes de esto son lás siguientes : 

| Metrica                   | Valor  |
|---------------------------|--------|
| Accuracy                  | 0.8307 |
| Sensitivity               | 0.8655 |
| Specificity               | 0.7714 |
| Precision                 | 0.8655 |
| Negative Predictive Value | 0.7714 |
| False Positive Rate       | 0.2286 |
| False Discovery Rate      | 0.1345 |
| False Negative Rate       | 0.1345 |
| F1 Score                  | 0.8655 |
