# ElectroMagnetismo
# Simulación de Campo Magnético de un Solenoide

Este proyecto en MATLAB simula, calcula y visualiza el campo magnético tridimensional generado por un conjunto de espiras (solenoide) aplicando la ley de Biot-Savart.

## Características

* Generación paramétrica de la geometría de las espiras.
* Cálculo numérico del campo magnético vectorial ($B_x, B_y, B_z$) sobre una cuadrícula 3D.
* Visualización del campo magnético mediante un mapa de calor (magnitud) y líneas de flujo (dirección) en el plano transversal XZ.

## Estructura del Proyecto

El código está modularizado en Live Scripts de MATLAB (`.mlx`):

* **`MainEspiras.mlx`**: Script principal de ejecución. Define los parámetros iniciales físicos y geométricos (corriente, número de espiras, radio, separación) y coordina el flujo del programa.
* **`dibujar_espiras_y_dl.mlx`**: Función encargada de calcular los puntos espaciales ($x, y, z$) del alambre y los vectores de longitud diferencial ($dl_x, dl_y, dl_z$).
* **`campoB.mlx`**: Motor de cálculo. Crea la cuadrícula espacial (grid 3D) y aplica la integración numérica de Biot-Savart para obtener los vectores de campo magnético.
* **`visualizar_campo.mlx`**: Módulo de graficación. Extrae un corte en el plano XZ ($y=0$), calcula la magnitud neta del campo y plotea las gráficas de superficie y flujo.

## Requisitos

* **MATLAB** (Los archivos `.mlx` indican compatibilidad base con R2025b, aunque versiones anteriores soportan Live Scripts).
* No requiere Toolboxes de pago adicionales.

## Uso

1. Descarga todos los archivos `.mlx` en un mismo directorio.
2. Abre MATLAB y navega hasta dicho directorio.
3. Abre el archivo **`MainEspiras.mlx`**.
4. (Opcional) Modifica las variables de inicialización en la primera celda del código para alterar el comportamiento físico del sistema:
   ```matlab
   nI = 5;    % Número de espiras
   R = 1.5;   % Radio de cada espira (m)
   I = 300;   % Corriente (A)
   sz = 1;    % Separación entre espiras (m)
