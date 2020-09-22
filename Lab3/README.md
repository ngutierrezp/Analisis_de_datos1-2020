# Lab 3 Analisis de datos 1-2020: Reglas de Asociación

Las reglas de asociación son una forma de describir el comportamiento de ciertos patrones en base a una implicación; *si ocurre **A**, entonces, ocurre **B** ( con una determinada confianza)*. Esta reglas forman parte de la obtención del conocimiento y lo aportan para analizar que elementos ocurren con mas frecuencia.

Como su uso es tan variado, existen diferentes algoritmos para obtener reglas de asociación. Uno de los más utilizados y sencillos de trabajar es el algoritmo **Apriori**.

En este código se aplicará el algoritmo Apriori en en el dataset *heart-disease* para la obtención de reglas de asociación de diferentes características que tiene un paciente. 


## Objetivos

- Explicar el funcionamiento del Algoritmo Apriori.
- Explicar los pasos a seguir para la obtención de las reglas de asociación.
- Analizar las reglas obtenidas.
- Realizar una conclusión del análisis de las reglas.

## Definición con interpretación medica de las variables:

| Atributo | Criterio                                                                                                                                                                  | Valor                                                                                        |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| age      | Siguen una distribución normal por lo que se divide en dos proporciones similares\. A partir de los 54 años\.                                                             | OA\(Old Adult\) = \[54, Máx Edad\] YA\(Young Adult\) = \[Min Edad, 53\]                      |
| sex      | Esta discretizada                                                                                                                                                         | Hombre = 1,  Mujer = 0                                                                       |
| cp       | Tiene valores discretos                                                                                                                                                   | Angina típica = 1, Angina Atípica = 2, Dolor no Anginal = 3 y asintomático = 4               |
| trestbps | Este valor es normal si esta dentro de \[120\-129\] mmHg\. Sobre 129 mmHg indica Hipertensión                                                                             | Sobre 129 mmHg = Hiper, Bajo 129 mmHg = normal                                               |
| chol     | Un nivel de colesterol es considerado saludable hasta los 200 mg/dL                                                                                                       | Sobre los 200 mg/dL = healthy, bajo los 200 mg/dL = no healthy                               |
| fbs      | Esta discretizada                                                                                                                                                         | 0 = no diabético, 1 = diabético                                                              |
| restecg  | Valores discretizados                                                                                                                                                     | Normal = 0, Anormalidad en la onda ST\-T = 1, Hipertrofia ventricular izquierda probable = 2 |
| thalach  | Valor estandar depende del sexo y de la edad\.                                                                                                                            | Sobre el estandar = anormal, Bajo el estandar = normal                                       |
| exang    | Esta discretizada                                                                                                                                                         | Verdadero = 1, Falso = 0                                                                     |
| oldpeak  | Esta variable tiene un significado netamente médico, por lo que no se hacer una clasificación de forma aproximada\. Solo se define si el valor esta sobre la media o no\. | Sobre la media = high, Bajo la media = low                                                   |
| slope    | Esta discretizado                                                                                                                                                         | Ascendente = 1, Plano = 2 y Descendente = 3                                                  |
| ca       | Esta discretizado                                                                                                                                                         | 0,1,2 o 3 vasos coloreados                                                                   |
| thal     | Esta discretizado                                                                                                                                                         | Normal = 3, Defecto arreglado = 6 y Defecto reversible = 7                                   |
| num      | Clase                                                                                                                                                                     | Sano = 0, Enfermo = 1                                                                        |

