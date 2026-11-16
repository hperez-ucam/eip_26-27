# conservadas.py
# Dice en qué posiciones coinciden todas las secuencias de un fichero FASTA de ProteinMPNN.

import sys                                      # para leer el nombre del fichero de la línea de comandos

if len(sys.argv) < 2:                           # si no se ha indicado ningún fichero...
    sys.exit("Uso: python3 conservadas.py <fichero.fa>")   # ...se avisa y se termina

secuencias = []                                 # aquí se van guardando las secuencias leídas
with open(sys.argv[1]) as fichero:              # abre el fichero y lo cierra al salir del bloque
    for linea in fichero:                       # recorre el fichero línea a línea
        linea = linea.strip()                   # quita el salto de línea y los espacios del final
        if linea.startswith(">"):               # una línea que empieza por > es una cabecera
            secuencias.append("")               # así que empieza una secuencia nueva, todavía vacía
        elif linea and secuencias:              # si no es cabecera, no está vacía y ya hay cabecera...
            secuencias[-1] += linea             # ...se añade a la última secuencia empezada

entrada = secuencias[0]                         # la primera es la secuencia que venía en el esqueleto
disenos = secuencias[1:]                        # las demás son los diseños de ProteinMPNN

validas = [i for i in range(len(entrada))       # posiciones que ProteinMPNN ha podido leer:
           if entrada[i] != "X"]                # las que no son X (la X marca un residuo no estándar)

conservadas = []                                # posiciones donde todos los diseños coinciden
for i in validas:                               # solo se recorren las posiciones válidas
    letras = {d[i] for d in disenos}            # las letras distintas que hay en esa posición
    if len(letras) == 1:                        # una sola letra: todos los diseños coinciden
        conservadas.append(i + 1)               # se guarda la posición contando desde 1

print("diseños leídos:", len(disenos))
print("posiciones válidas:", len(validas), "de", len(entrada), "(las X no se cuentan)")
print("posiciones conservadas:", len(conservadas),
      "= %.1f %% de las válidas" % (100 * len(conservadas) / len(validas)))
print("posición y aminoácido:", [(p, disenos[0][p - 1]) for p in conservadas])
