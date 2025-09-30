#!/bin/bash

# Obtener la lista de paquetes que se pueden actualizar
paquetes=$(apt list --upgradable -a 2>/dev/null | grep -v "Listando..." | tail -n +2)

# Verificar si hay paquetes para actualizar
if [[ -z "$paquetes" ]]; then
    echo "No hay paquetes para actualizar."
    exit 0
fi
# Guardar la lista de paquetes en paquetes.txt
echo "$paquetes" > paquetes1.txt
cut -d'/' -f1 paquetes1.txt > paquetes.txt
echo "Los paquetes actualizables se han guardado en paquetes.txt."
sleep 1
echo "Procedemos a instalar los paquetes"
xargs -a paquetes.txt sudo apt install --only-upgrade -y
rm paquet*.*
# cat paquetes.txt
echo ""
echo ""
echo "Hemos borrado los archivos temporales y actualizado correctamente"

