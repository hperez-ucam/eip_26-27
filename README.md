# Estructura e Ingeniería de Proteínas 26-27

Material de clase de los **Bloques 5 y 6, Diseño computacional de proteínas**. Grado en
Biotecnología, 3.º curso, UCAM. Profesor: Horacio Pérez Sánchez.

Aquí están los ficheros que aparecen en las diapositivas: las salidas reales de cada programa,
las estructuras con las que se trabaja, las sesiones de PyMOL y los scripts de las tareas. No
hay que copiar nada a mano de la pantalla.

El resto de la asignatura, incluidos los bloques que imparte Rubén Zapata, está en el campus
virtual.

## Cómo se usa

En el servidor de clase:

```bash
git clone https://github.com/hperez-ucam/eip_26-27.git
cd eip_26-27
```

Cada vez que empieza una clase, para tener lo último:

```bash
cd ~/eip_26-27 && git pull
```

Las sesiones de PyMOL se abren en el portátil, no en el servidor. Se copian desde una terminal
del portátil, cambiando `USUARIO` y la dirección del servidor, que está en el campus virtual:

```bash
scp USUARIO@SERVIDOR:eip_26-27/pymol/p53-plddt_v2.pse .
```

## Qué hay en cada directorio

| Directorio | Contenido | Clase |
|---|---|---|
| `estructuras/` | Entradas del PDB y modelos de AlphaFold DB que se usan en clase | 5.1 a 6.6 |
| `pymol/` | Cinco sesiones de PyMOL, con la escena ya montada | 5.1, 6.1, 6.2 |
| `salidas/` | Salidas reales de ColabFold y US-align, tal como las devolvió el servidor | 5.1, 6.1, 6.2 |
| `secuencias/` | Diseños de ProteinMPNN y el script `conservadas.py` de la tarea 6.4 | 6.4 |
| `disenos/` | La tabla de 50 diseños con sus métricas, para la tarea 6.5 | 6.5 |
| `colab/` | Cuaderno de Colab para probar BioEmu-2 | 6.2 |

## Las estructuras

| Fichero | Qué es |
|---|---|
| `1ema.pdb` | GFP, cristal |
| `af-P42212.pdb` | GFP, modelo de AlphaFold DB. Se compara con el cristal en `salidas/usalign-gfp.txt` |
| `1d3z.pdb` | Ubiquitina, 10 conformaciones de RMN en el mismo fichero |
| `af-P04637.pdb` | p53 humana, modelo de AlphaFold DB. Dos dominios resueltos y un conector sin estructura |
| `af-P37840.pdb` | Alfa-sinucleína, modelo de AlphaFold DB. Proteína desordenada |
| `1ake.pdb` y `4ake.pdb` | Adenilato quinasa, cerrada y abierta. La misma proteína en dos estados |
| `af-P69441.pdb` | Adenilato quinasa de *E. coli*, modelo de AlphaFold DB |
| `1igt.pdb` | Inmunoglobulina G completa |
| `1mel.pdb` | Nanobody unido a lisozima |

## Las sesiones de PyMOL

Se abren con `File > Open` en PyMOL. Traen la escena montada: la orientación, los colores y lo
que está representado. Se pueden girar y medir.

| Fichero | Qué muestra |
|---|---|
| `p53-plddt_v2.pse` | p53 coloreada por pLDDT, con su escala de color |
| `desorden-ubiquitina_v1.pse` | Las 10 conformaciones de RMN de la ubiquitina, a la vez |
| `desorden-asinucleina_v2.pse` | Alfa-sinucleína: lo que devuelve un predictor ante una proteína sin estructura |
| `gfp-modelo-vs-cristal_v1.pse` | Modelo de AlphaFold y cristal de la GFP, superpuestos |
| `adk-dos-estados_v1.pse` | Adenilato quinasa, cerrada y abierta, superpuestas |

## Con qué y cuándo se calculó

Todo lo de `salidas/` se calculó en el servidor de clase, sin tarjeta gráfica:

- **ColabFold 1.6.3** (AlphaFold 2), el 04/11/2026 y el 06/11/2026.
- **US-align, versión 20260527**, el 04/11/2026.
- **ProteinMPNN**, el 04/11/2026.

Los tiempos que aparecen en los ficheros son reales y sirven para calcular cuánto tardará lo
vuestro. La ubiquitina, de 76 residuos, tardó 87 segundos con un solo modelo y un solo reciclado.

La tabla de `disenos/` es **sintética**. No es un cálculo real: está construida para que el
ejercicio de la clase 6.5 tenga respuestas defendibles. Las métricas y sus umbrales sí son los
de BindCraft.

## Lo que no está aquí

- Las soluciones de las tareas y de los ejercicios de clase.
- Los enunciados. Mandan los del campus virtual.
- Las diapositivas. Están en el campus virtual.
- Los programas de diseño (RFdiffusion, ProteinMPNN, BindCraft). Están instalados en el
  servidor de clase, y cada diapositiva lleva la dirección de su repositorio original.
