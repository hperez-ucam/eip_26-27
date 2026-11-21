#!/bin/bash
# contar_homologos.sh - cuenta cuantas secuencias homologas encuentra ColabFold para
# cada una de las cinco dianas con accesion de UniProt, sin predecir la estructura.
#
# Uso, desde el directorio prediccion/:
#   ./contar_homologos.sh
#
# Material complementario del apartado 5.1, «Funcionamiento de AlphaFold 2».
# La busqueda va al servidor remoto de MMseqs2 y tarda unos segundos por diana;
# en el servidor de clase no se calcula nada pesado.

set -u                      # si se usa una variable sin definir, se para

# Las cinco dianas: GFP, p53, alfa-sinucleina, adenilato quinasa y rodopsina.
# Baja la secuencia de cada una de UniProt, igual que el paso 1 de predecir_una.sh.
# -s sin barra de progreso, -f falla si la accesion no existe, -o guarda en un fichero.
for a in P42212 P04637 P37840 P69441 P02699; do
    curl -sf -o "$a.fasta" "https://rest.uniprot.org/uniprotkb/$a.fasta"
done

# --msa-only hace solo la busqueda de homologos y guarda el alineamiento en msa_$a/.
# Lo que ColabFold escribe en pantalla se guarda en msa_$a.log para no ensuciar.
for a in P42212 P04637 P37840 P69441 P02699; do \
    colabfold_batch --msa-only $a.fasta msa_$a > msa_$a.log 2>&1; done

# Cada secuencia del fichero .a3m empieza por una linea con «>»: grep -c las cuenta.
# La red usa como mucho 512 + 5120 = 5632; las que pasan de ahi no cuentan.
for a in P42212 P04637 P37840 P69441 P02699; do \
    echo "$a $(grep -c '^>' msa_$a/*.a3m)"; done
