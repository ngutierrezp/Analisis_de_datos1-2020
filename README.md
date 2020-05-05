# Lab 1 Analisis de datos 1-2020

A continuación se describe la parte del código realizado para el primer laboratorio programado de Analisis de Datos 1-2020.

El código fue hecho en el lenguaje R y se utilizó el dataset de [heart-disease](https://archive.ics.uci.edu/ml/datasets/Heart+Disease) para analizar sus varibles.

Dentro de este dataset se encuentran 4 subdataset los cuales pertenecen a 4 lugares distintos donde se tomaron muestras:

 1. Cleveland Clinic Foundation (cleveland.data)
 2. Hungarian Institute of Cardiology, Budapest (hungarian.data)
 3. V.A. Medical Center, Long Beach, CA (long-beach-va.data)
 4. University Hospital, Zurich, Switzerland (switzerland.data)


Cada subdataset posee 74 atributos diferentes de los cuales 14 son los mas importantes o los con mayor presencia.

Algunos de estos subdataset poseen información corrupta y no legible, por lo que se ha decido utilizar los subdataset que fueron procesados con anterioridad por la entidad publicadora del dataset.

[![corrupted-data.png](https://i.postimg.cc/wBtfFHMw/corrupted-data.png)](https://postimg.cc/2qD78s4W)

##Atributos importantes

A continuacion se presenta una pequeña explicacion para cada dato utilizado en el subdataset procesado, ademas de indicar que tipo de variable corresponde. 

|Atributo|Descripción|Categoría|
|--------|-----------|---------|
|age|Edad en años|Númerica discreta|
|sex|Sexo de la persona|Dicotómica|
|cp|Tipo de dolor del pecho|Categórica nominal|
|trestbps|Presión arterial en reposo al ser admitido en el hospital (mmHg)|Númerica discreta|
|chol|Colesterol sérico (mg/dl) > 120mg/dl (1 = verdadero ; 0 = falso)|Númerica discreta|
|fbs|Glucemia en ayunas|Dicotómica|
|restecg|Resultados electrocardiográficos en reposo|Categórica ordinal|
|thalach|Frecuencia cardíaca máxima alcanzada|Númerica discreta|
|exang|Angina inducida por ejercicio|Dicotómica|
|oldpeak|Depresión del ST inducida por el ejercicio relativo al descanso|Númerica Discreta|
|slope|La pendiente del segmento ST de ejercicio pico|Categórica Nominal|
|ca|Número de vasos principales coloreados por flourosopía|Númerica Continua|
|thal|3 = normal; 6 = defecto arreglado; 7 = defecto reversible|Categórica Nominal|
|num|Diagnóstico de enfermedad cardíaca. Toma valores de 0 a 4 segun la gravedad de la enfermedad, siendo 0 que no hay enfermedad y 4 una enfermedad cardíaca grabe|Categórica Ordinal|

Cabe destacar que todos los atributos son representados por números, así que a pesar de que algunos atributos sean clasificados en categorías estas son representados con valores. Los atributos que cumplen esta condición son los siguientes:

- cp:
    - Valor 1: angina típica.
    - Valor 2: angina atípica.
    - Valor 3: dolor no anginal.
    - Valor 4: asintomático.
- restecg:
    - Valor 0: Normal.
    - Valor 1: Que tiene anormalidad en la onda ST-T (inversiones de onda T y / o ST elevación o depresión de> 0.05 mV).
    - Valor 2: Que muestra hipertrofia ventricular izquierda probable o definitiva según los criterios de Estes.
- slope:
    - Valor 1: Ascendente.
    - Valor 2: Plano.
    - Valor 3: Descendente.
