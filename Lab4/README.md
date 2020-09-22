# Lab 4 Analisis de datos 1-2020: Reglas de Asociación

Los árboles de decisión permiten ver de manera intuitiva la clasificación y predicción hecha por el modelo a través de una manera gráfica 

En este código se aplica arboles de decisión para *Heart disease dataset*, para ver cómo se comportan y además de ofrecer una comparación con lo obtenido en el trabajo anterior [Laboratorio 3: Reglas de Asociación](https://github.com/ngutierrezp/Labs-Analisis-de-datos/tree/master/Lab3)

## Objetivos 


- Explicar el funcionamiento de los árboles de decisión.
- Explicar los pasos a seguir para la obtención del árbol de decisión.
- Analizar árbol de decisión obtenido.
- Comparar resultados del árbol de decisión con las reglas de asociación obtenidas en el Laboratorio 3. 
- Realizar una conclusión del árbol obtenido.

## Resultados

El árbol final resultante es producto de la aplicación de algoritmos de **Boosting** y una estrategia de **Winnowing**: 

![Imgur](https://i.imgur.com/KZicDUl.png)

**NOTA :** Para la creación del modelo se ha utilizado un 70% de los datos y el 30% restante se ha utilizado para la prueba del modelo.

|                     | Real Enfermos | Real Sanos | Total |
|---------------------|---------------|------------|-------|
| **Predicción Enfermos** | 98           | 31         | 129   |
| **Predicción Sanos**    | 18            | 129         | 147    |
| **Total**               | 116           | 160         | 276   |

Las metricas resultantes de esto son lás siguientes : 

| Metrica                   | Valor  |
|---------------------------|--------|
| Accuracy                  | 0.8225 |
| Sensitivity               | 0.8448 |
| Specificity               | 0.8063 |
| Precision                 | 0.7597 |
| Negative Predictive Value | 0.8776 |
| False Positive Rate       | 0.1938 |
| False Discovery Rate      | 0.2403 |
| False Negative Rate       | 0.1552 |
| F1 Score                  | 0.8000 |
