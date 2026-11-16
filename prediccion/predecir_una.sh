#!/bin/bash
# predecir_una.sh - predice la estructura de UNA proteina con ColabFold.
#
# Uso:
#   ./predecir_una.sh P42212 resultados
#
#   P42212      identificador de UniProt de la proteina
#   resultados  directorio donde se dejan los ficheros de salida
#
# Lo que hace, en tres pasos: baja la secuencia de UniProt, lanza la prediccion
# y escribe en pantalla el pLDDT que ha salido.
#
# Este script es el punto de partida de la tarea 5.1. La tarea pide ampliarlo
# para que prediga varias proteinas seguidas, no una sola.

set -u                      # si se usa una variable sin definir, se para
set -e                      # si falla una orden, se para y no sigue

if [ "$#" -ne 2 ]; then     # $# es el numero de argumentos recibidos
    echo "Uso: $0 ACCESION_UNIPROT DIRECTORIO_DE_SALIDA"
    echo "Ejemplo: $0 P42212 resultados"
    exit 1                  # salir con error, para que se note que no ha corrido
fi

ACCESION="$1"               # el primer argumento: la proteina
SALIDA="$2"                 # el segundo: donde dejar los resultados

# command -v dice si una orden existe y donde esta. Si ColabFold no esta
# instalado, conviene pararse aqui y decirlo, en vez de bajar la secuencia y
# fallar despues.
if ! command -v colabfold_batch > /dev/null; then
    echo "ERROR: no encuentro colabfold_batch."
    echo "En el servidor de clase esta en /opt/colabfold y se llama sin ruta."
    echo "Si esto sale en el servidor de clase, avisa al profesor."
    exit 1
fi

mkdir -p "$SALIDA"          # -p no se queja si el directorio ya existe

# ── 1. La secuencia ──────────────────────────────────────────────────────────
# UniProt sirve la secuencia en formato FASTA en una direccion fija. Se baja con
# curl: -s no imprime la barra de progreso, -f falla si la direccion no existe,
# -o guarda la respuesta en un fichero.
FASTA="$SALIDA/$ACCESION.fasta"
echo "== Bajando la secuencia de $ACCESION =="
curl -sf -o "$FASTA" "https://rest.uniprot.org/uniprotkb/$ACCESION.fasta"

# wc -c cuenta los caracteres del fichero. Si la accesion no existe, UniProt
# devuelve un fichero vacio y conviene pararse aqui y no gastar el calculo.
if [ ! -s "$FASTA" ]; then
    echo "ERROR: UniProt no ha devuelto ninguna secuencia para $ACCESION"
    exit 1
fi

# grep -v '>' quita la linea de cabecera; tr -d '\n' junta todas las lineas;
# wc -c cuenta los aminoacidos que quedan.
RESIDUOS=$(grep -v '>' "$FASTA" | tr -d '\n' | wc -c)
echo "   $RESIDUOS residuos"

# ── 2. La prediccion ─────────────────────────────────────────────────────────
# --num-models 1   un solo modelo en vez de los cinco de por defecto
# --num-recycle 1  una sola pasada de refinado
# Las dos opciones son para que el calculo quepa en una clase. Para un resultado
# de verdad se quitan las dos y se dejan los valores por defecto.
echo "== Prediciendo $ACCESION =="
colabfold_batch --num-models 1 --num-recycle 1 "$FASTA" "$SALIDA/$ACCESION"

# ── 3. El pLDDT ──────────────────────────────────────────────────────────────
# ColabFold deja un fichero log.txt con una linea por modelo. La linea que
# interesa es la del ranking, que trae el pLDDT medio.
# grep busca esa linea, tail -1 se queda con la ultima.
echo "== Resultado =="
grep "rank_001" "$SALIDA/$ACCESION/log.txt" | tail -1
