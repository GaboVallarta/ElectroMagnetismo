# ElectroMagnetismo

# Simulación de Campo Magnético de un Solenoide y Frenado Magnético

Este proyecto en MATLAB modela el campo magnético generado por un solenoide mediante la ley de Biot-Savart y analiza la interacción dinámica entre dicho campo y un dipolo magnético en movimiento. El programa calcula el campo magnético tridimensional, el flujo magnético inducido y simula la trayectoria de un imán sometido a fuerzas electromagnéticas utilizando integración numérica de Runge-Kutta de cuarto orden (RK4).

## Características

* Generación paramétrica de la geometría de las espiras que conforman el solenoide.
* Cálculo numérico del campo magnético vectorial ((B_x, B_y, B_z)) sobre una cuadrícula tridimensional.
* Visualización del campo magnético mediante mapas de intensidad y líneas de flujo.
* Cálculo del flujo magnético a través de una superficie circular.
* Obtención de derivadas espaciales del campo magnético.
* Simulación de fuerzas inducidas por corrientes de Foucault (Eddy Currents).
* Resolución numérica de la ecuación de movimiento utilizando el método de Runge-Kutta de cuarto orden.
* Comparación entre caída libre y caída bajo frenado magnético.

---

## Descripción Física

El proyecto modela un sistema electromagnético compuesto por un solenoide alimentado con corriente eléctrica y un dipolo magnético que se desplaza a lo largo de su eje principal.

A partir de la ley de Biot-Savart se calcula la distribución espacial del campo magnético generado por el conjunto de espiras. Posteriormente, dicho campo se emplea para determinar el flujo magnético a través de una superficie de referencia y estimar la fuerza electromagnética inducida que actúa sobre el dipolo.

Finalmente, se resuelve la ecuación de movimiento del sistema para estudiar el efecto del frenado magnético y comparar la trayectoria obtenida con la correspondiente a una caída libre.

---

## Estructura del Proyecto

El código está modularizado en funciones independientes:

### `main.m`

Script principal encargado de:

* Definir los parámetros físicos y geométricos.
* Construir la geometría del solenoide.
* Calcular el campo magnético.
* Obtener el flujo magnético.
* Simular la dinámica del dipolo.
* Generar todas las visualizaciones.

### `dibujar_espiras_y_dl.m`

Genera la geometría tridimensional de las espiras y calcula los vectores diferenciales de longitud (d\vec{l}) utilizados por la ley de Biot-Savart.

### `campoB.m`

Calcula las componentes del campo magnético sobre una cuadrícula tridimensional mediante integración numérica de la ley de Biot-Savart.

### `visualizar_campo.m`

Genera mapas de intensidad y líneas de flujo del campo magnético en el plano XZ.

### `flujoB.m`

Calcula el flujo magnético a través de una superficie circular a partir de la componente (B_z).

### `calcular_Bz_eje.m`

Obtiene la distribución del campo magnético sobre el eje del solenoide y calcula su derivada espacial.

### `a_total_eddy.m`

Calcula la aceleración instantánea considerando:

* Fuerza electromagnética inducida.
* Fuerza de fricción.
* Fuerza gravitacional.

### `trayectoria.m`

Resuelve la ecuación de movimiento mediante el método de Runge-Kutta de cuarto orden (RK4).

### `simular_caida.m`

Simula la caída de un dipolo magnético utilizando el gradiente del campo magnético sobre el eje del solenoide.

---

## Metodología

El programa sigue las siguientes etapas:

### 1. Generación de la geometría

Se construyen las espiras circulares que conforman el solenoide y se calculan los elementos diferenciales de corriente.

### 2. Cálculo del campo magnético

Se aplica numéricamente la ley de Biot-Savart:

[
d\vec{B}=\frac{\mu_0 I}{4\pi}\frac{d\vec{l}\times\vec{r}}{r^3}
]

sumando la contribución de todos los segmentos de corriente sobre cada punto de la malla tridimensional.

### 3. Obtención del flujo magnético

Se integra la componente axial del campo magnético sobre una superficie circular para obtener:

[
\Phi_B=\int \vec{B}\cdot d\vec{A}
]

### 4. Cálculo de fuerzas inducidas

A partir de la variación espacial del flujo magnético se calcula la fuerza electromagnética asociada a corrientes inducidas.

### 5. Simulación dinámica

La trayectoria del dipolo magnético se obtiene resolviendo numéricamente la ecuación de movimiento mediante RK4.

---

## Variables Principales

### Parámetros Iniciales (Físicos y Geométricos)

* **`nI`**: Número total de espiras.
* **`N`**: Número de puntos utilizados para discretizar cada espira.
* **`R`**: Radio de las espiras (m).
* **`R2`**: Radio de la superficie utilizada para calcular flujo magnético (m).
* **`sz`**: Separación entre espiras consecutivas (m).
* **`I`**: Corriente eléctrica aplicada (A).
* **`N_vueltas`**: Número de vueltas efectivas consideradas.
* **`I_efectiva`**: Corriente efectiva utilizada en el cálculo.
* **`mo`**: Permeabilidad magnética del vacío.
* **`km`**: Constante de Biot-Savart.
* **`rw`**: Grosor efectivo del conductor.

### Coordenadas y Geometría

* **`x, y, z`**: Coordenadas de los segmentos del conductor.
* **`dlx, dly, dlz`**: Componentes del vector diferencial de longitud.
* **`Mx, My, Mz`**: Ejes de la cuadrícula tridimensional.

### Parámetros Dinámicos

* **`m_masa`**: Masa del dipolo magnético (kg).
* **`momento_z`**: Momento magnético del dipolo (A·m²).
* **`gamma`**: Coeficiente de fricción viscosa.
* **`z0`**: Posición inicial (m).
* **`v0`**: Velocidad inicial (m/s).
* **`dt`**: Paso temporal de integración (s).

### Variables de Salida

* **`Bx, By, Bz`**: Componentes del campo magnético.
* **`Bmag`**: Magnitud del campo magnético.
* **`phiB`**: Flujo magnético.
* **`dPhi_dz`**: Derivada espacial del flujo.
* **`dBz_dz`**: Derivada espacial del campo axial.
* **`pos`**: Posición del dipolo.
* **`vel`**: Velocidad del dipolo.

---

## Resultados Generados

El programa genera:

* Geometría tridimensional del solenoide.
* Visualización de los vectores diferenciales (d\vec{l}).
* Distribución espacial del campo magnético.
* Líneas de flujo magnético.
* Flujo magnético sobre una superficie circular.
* Derivada espacial del campo magnético.
* Trayectoria temporal del dipolo magnético.
* Comparación entre caída libre y caída con frenado magnético.

---

## Requisitos

* MATLAB R2025b o superior.

---

## Uso

1. Descarga todos los archivos `.m`.
2. Colócalos en un mismo directorio de trabajo.
3. Abre MATLAB.
4. Navega hasta la carpeta del proyecto.
5. Ejecuta:

```matlab
main
```

6. El programa generará automáticamente las gráficas y simulaciones.

---

## Referencias

1. Griffiths, D. J. *Introduction to Electrodynamics*. Pearson Education.
2. Hayt, W. H., Buck, J. A. *Engineering Electromagnetics*. McGraw-Hill.
3. Sadiku, M. N. O. *Elements of Electromagnetics*. Oxford University Press.
4. MATLAB Documentation.
5. Ley de Biot-Savart y fundamentos de electromagnetismo clásico.

---

## Autores

* Gabriel Vallarta
* Sofía Arredondo
* Alan
* Ángel
