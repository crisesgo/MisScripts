#!/bin/bash

#VARIABLES DE COLOR
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
grey=`tput setaf 8`
reset=`tput sgr0`
bold=`tput bold`
underline=`tput smul`


if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
    echo -e "${yellow}Uso: $0 <IP> <PUERTO_INICIAL> <PUERTO_FINAL> [TIMEOUT]${reset}"
    echo -e "Ejemplo: ${green}$0 192.168.1.1 20 1000${reset} (timeout por defecto: 1s)"
    echo -e "Ejemplo: ${green}$0 192.168.1.1 20 1000 2${reset} (timeout personalizado: 2s)"
    exit 1
fi
ip=$1
port_start=$2
port_end=$3
timeout_val=${4:-1}

echo -e "${blue}Escaneando puertos abiertos en $ip...${reset}"
for port in $(seq $port_start $port_end); do
    (timeout $timeout_val bash -c "echo >/dev/tcp/$ip/$port") 2>/dev/null && {
    service=$(nc -v -z -w $timeout_val $ip $port 2>&1 | grep "succeeded" | awk '{print $4}')
    echo -e "${green}[+] Puerto $port abierto - Servicio: ${service:-Desconocido}${reset}"
    } &
done
wait
