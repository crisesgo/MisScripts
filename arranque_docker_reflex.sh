#!/bin/bash

# Definimos los colores como variables
rojo='\e[1;31m'
verde='\e[0;32m'
amarillo='\e[0;33m'
azul='\e[0;34m'
magenta='\e[0;35m'
cyan='\e[0;36m'
negro='\e[0;30m'
gris_claro='\e[0;37m'
blanco='\e[1;37m'
sin_color='\e[0m'


echo -e "[${rojo}ACTUALIZANDO....${sin_color}]"
echo ""
apt update && apt upgrade -y && apt autoremove -y
echo ""
echo -e "[${rojo}INSTALANDO DEPENDENCIAS ...${sin_color}]"
echo ""
apt install -y --no-install-recommends unzip curl build-essential
echo ""
echo -e "[${rojo}ACTUALIZANDO pip ...${sin_color}]"
echo ""
pip install --upgrade pip
echo ""
echo -e "[${rojo}INSTALANDO reflex....${sin_color}]"
echo ""
pip install reflex
echo ""
echo -e "[${rojo}INICIALIZANDO reflex init ...${sin_color}]"
echo ""
reflex init
echo ""
echo -e "[${rojo}ARRANCANDO reflex ...${sin_color}]"
echo ""
reflex run

