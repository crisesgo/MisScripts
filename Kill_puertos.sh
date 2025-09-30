#!/bin/bash
# Definimos los colores como variables
rojo='\e[1;31m'
verde='\e[0;32m'
amarillo='\e[1;33m'
azul='\e[1;34m'
magenta='\e[0;35m'
cyan='\e[0;36m'
negro='\e[0;30m'
gris_claro='\e[0;37m'
blanco='\e[1;37m'
sin_color='\e[0m'

echo ""
echo -e "[${amarillo}OBTENIENDO pids....${sin_color}]"
echo ""
# Obtener la lista de paquetes que se pueden actualizar
paquetes=$(sudo ss -tulnp | grep -E 'reflex' | grep -oP 'pid=\K\d+' && sudo ss -tulnp | grep -E 'bun' | grep -oP 'pid=\K\d+')

# Verificar si hay paquetes para actualizar
if [[ -z "$paquetes" ]]; then
    echo "No hay PID's para actualizar."
    exit 0
fi
#echo $paquetes
# Guardar la lista de paquetes en paquetes.txt
echo "$paquetes" > pids.txt
# cut -d'/' -f1 paquetes1.txt > paquetes.txt
# echo "Los paquetes actualizables se han guardado en paquetes.txt."
# sleep 1
# echo "Procedemos a instalar los paquetes"

xargs -a pids.txt -r sudo kill -9
rm pids.txt



