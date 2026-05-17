# ElectroMagnetismo
# Simulación de Campo Magnético de un Solenoide

Este proyecto en MATLAB simula, calcula y visualiza el campo magnético tridimensional generado por un conjunto de espiras, aplicando la ley de Biot-Savart.

## Características

* Generación paramétrica de la geometría de las espiras.
* Cálculo numérico del campo magnético vectorial ($B_x, B_y, B_z$) sobre una cuadrícula 3D.
* Visualización del campo magnético mediante y líneas de flujo.

## Estructura del Proyecto

El código está modularizado en Live Scripts de MATLAB (`.mlx`):

* **`MainEspiras.mlx`**: Script principal de ejecución. Define los parámetros iniciales físicos y geométricos (corriente, número de espiras, radio, separación) y coordina el flujo del programa.
* **`dibujar_espiras_y_dl.mlx`**: Función encargada de calcular los puntos espaciales ($x, y, z$) del alambre y los vectores de longitud diferencial ($dl_x, dl_y, dl_z$).
* **`campoB.mlx`**: Motor de cálculo. Crea la cuadrícula espacial (grid 3D) y aplica la integración numérica de Biot-Savart para obtener los vectores de campo magnético.
* **`visualizar_campo.mlx`**: Módulo de graficación. Extrae un corte en el plano XZ ($y=0$), calcula la magnitud neta del campo y plotea las gráficas de superficie y flujo.

## Requisitos

* **MATLAB** R2025b

## Uso

1. Descarga todos los archivos `.mlx` en un mismo directorio.
2. Abre MATLAB y navega hasta dicho directorio.
3. Abre el archivo **`MainEspiras.mlx`**.

## Variables Principales

A continuación se detallan los parámetros y variables clave que controlan la física y geometría de la simulación:

### Parámetros Iniciales (Físicos y Geométricos)
* **`nI`**: Número total de espiras que conforman el solenoide.
* **`N`**: Resolución de la curva; define cuántos puntos espaciales se calculan para trazar cada espira.
* **`R`**: Radio de las espiras expresado en metros (m).
* **`sz`**: Separación longitudinal (sobre el eje Z) entre cada espira contigua (m).
* **`I`**: Corriente eléctrica que circula por el alambre, dada en Amperios (A).
* **`rw`**: Tamaño de paso para la creación de la cuadrícula 3D (actúa también como tolerancia para evitar singularidades matemáticas cerca del alambre).
* **`mo`**: Permeabilidad magnética del vacío ($4\pi \times 10^{-7} \, \text{T}\cdot\text{m/A}$).
* **`km`**: Constante precalculada de Biot-Savart ($\frac{\mu_0 \cdot I}{4\pi}$) para optimizar las iteraciones.

### Coordenadas y Geometría
* **`x, y, z`**: Arreglos que contienen las coordenadas tridimensionales de la trayectoria del alambre.
* **`dlx, dly, dlz`**: Componentes cartesianas del vector diferencial de longitud ($d\vec{l}$), indispensables para la integración numérica.
* **`Mx, My, Mz`**: Vectores que definen los ejes de la cuadrícula espacial (Grid 3D) en la que se evaluará el campo electromagnético.

### Variables de Salida
* **`Bx, By, Bz`**: Matrices 3D que almacenan la intensidad del campo magnético vectorial en cada coordenada de la cuadrícula.
* **`Bmag`**: Magnitud neta del campo magnético en un punto específico ($\sqrt{B_x^2 + B_y^2 + B_z^2}$).

## Referencias


## Autores
* **

