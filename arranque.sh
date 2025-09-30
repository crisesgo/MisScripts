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
echo -e "[${amarillo}ACTUALIZANDO lista de paquetes....${sin_color}]"
echo ""
sudo apt update

echo ""
echo -e "[${amarillo}ACTUALIZANDO paquetes....${sin_color}]"
echo ""
sudo apt full-upgrade -y

echo ""
echo -e "[${rojo}ELIMINANDO paquetes innecesarios....${sin_color}]"
echo ""
sudo apt autoremove -y

echo ""
echo -e "[${rojo}LIMPIANDOO cache de paquetes....${sin_color}]"
echo ""
sudo apt clean

echo ""
echo -e "[${amarillo}VERIFICANDO integridad del sistema....${sin_color}]"
echo ""
sudo dpkg --configure -a 
sudo apt --fix-broken install

echo ""
echo -e "[${amarillo}COMPROBANDO si hay paquetes para actualizar....${sin_color}]"
echo ""


# Obtener la lista de paquetes que se pueden actualizar
paquetes=$(apt list --upgradable -a 2>/dev/null | grep -v "Listando..." | tail -n +2)

# Verificar si hay paquetes para actualizar
if [[ -z "$paquetes" ]]; then
    echo ""
    echo -e "[${azul}No hay paquetes para actualizar.${sin_color}]\n"
    echo -e "[${azul}SISTEMA ACTUALIZADO Y LIMPIO.${sin_color}]"
    echo ""
    exit 0
fi
# Guardar la lista de paquetes en paquetes.txt
echo "$paquetes" > paquetes1.txt
cut -d'/' -f1 paquetes1.txt > paquetes.txt
#echo "Los paquetes actualizables se han guardado en paquetes.txt."
sleep 1
#echo "Procedemos a instalar los paquetes"
xargs -a paquetes.txt sudo apt install --only-upgrade -y
rm -f paquet*.*
# cat paquetes.txt
#echo ""
#echo ""
#echo -e "Hemos borrado los archivos temporales y actualizado correctamente"
echo ""
echo -e "[${azul}Se han actualizado paquetes.${sin_color}]\n"
echo -e "[${azul}SISTEMA ACTUALIZADO Y LIMPIO.${sin_color}]"
echo ""



