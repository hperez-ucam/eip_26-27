# Predicción de estructura por línea de comandos

Material de la clase 5.1 y de su tarea. En clase se usa la interfaz web; aquí está el mismo
cálculo por línea de comandos, en el servidor de clase.

## Lo que hay

| Fichero | Qué hace |
|---|---|
| `predecir_una.sh` | Predice **una** proteína: baja su secuencia de UniProt, lanza ColabFold y escribe el pLDDT |
| `dianas.txt` | Los identificadores de UniProt de las seis dianas del bloque, uno por línea |

## Cómo se usa

En el servidor de clase:

```bash
cd ~/eip_26-27 && git pull
cd prediccion
chmod +x predecir_una.sh          # solo la primera vez
./predecir_una.sh P42212 resultados
```

Tarda unos tres minutos para una proteína de 76 residuos, y más cuanto más larga sea. El
servidor no tiene tarjeta gráfica, así que ColabFold avisa de ello y usa la CPU.

Al terminar deja en `resultados/P42212/`:

- el modelo en formato PDB,
- un `.json` con el pLDDT por residuo y la matriz PAE,
- `coverage.png`, con cuántas secuencias parientes se han encontrado,
- `log.txt`, con el registro completo del cálculo.

## Las dos opciones que lleva puestas

El script lanza `colabfold_batch --num-models 1 --num-recycle 1`. Las dos opciones recortan el
cálculo para que quepa en una clase:

- Sin `--num-models`, ColabFold calcula **cinco** modelos y se queda con el mejor.
- Sin `--num-recycle`, refina el modelo varias veces en vez de una.

Para un resultado que se vaya a publicar se quitan las dos. Para la tarea, se dejan.

## Lo que pide la tarea

Ampliar este script para que prediga **varias** proteínas seguidas, leyendo los identificadores
de `dianas.txt`. El enunciado completo, con lo que hay que entregar y el plazo, está en el
campus virtual.

Pistas, sin dar la solución:

- Un bucle `while read` lee un fichero línea a línea.
- Conviene saltarse las líneas vacías y las que empiezan por `#`.
- Si una proteína falla, el script no debería parar: las demás tienen que seguir.
- La tabla final se puede construir con `grep` sobre los `log.txt` que ya genera el script.
