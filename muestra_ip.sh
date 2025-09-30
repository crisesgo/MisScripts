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



verificar_e_instalar_jq() {
    # Verificar si jq está instalado
    if command -v jq &> /dev/null; then
        echo "jq ya está instalado."
        return 0
    fi

    echo "jq no está instalado. Procediendo a instalarlo..."

    # Detectar sistema operativo
    sudo apt update && sudo apt install -y jq || { echo "Error al instalar jq con apt"; return 1; }

    # Verificar nuevamente si se instaló correctamente
    if command -v jq &> /dev/null; then
        echo "jq se ha instalado correctamente."
        return 0
    else
        echo "Hubo un error al instalar jq."
        return 1
    fi
}
verificar_e_instalar_jq

if [ $? -eq 0 ]; then
		json_text=$(curl -s http://ip-api.com/json)
		json_text=$(curl -s https://ipinfo.com/json)
		
		if [ -z "$ip" ] || [ "$ip" == "null" ]; then
    	echo "${red}Error: No se pudo obtener la IP pública.${reset}"
    	exit 1
		fi
		
    ip=$(echo "$json_text" | jq -r '.query')
    city=$(echo "$json_text" | jq -r '.city')
    regionName=$(echo "$json_text" | jq -r '.regionName')
    country=$(echo "$json_text" | jq -r '.country')

		ip=$(echo "$json_text" | jq -r '.ip')
		city=$(echo "$json_text" | jq -r '.city')
		regionName=$(echo "$json_text" | jq -r '.region')
		country=$(echo "$json_text" | jq -r '.country')

    ubicacion="$city - $regionName - $country" 
    fecha=$(date +"%d-%m-%Y %H:%M:%S")
    echo "${bold}${red}== Red LOCAL==${reset}"
    ip_local=$(ip a | grep inet | awk 'NR==3' | awk '{print $2}' | cut -d'/' -f1)
    echo "${bold}${blue}$ip_local${reset}"
    echo "${bold}${red}== Red PUBLICA==${reset}"
    echo "${bold}${magenta}$ip ${yellow}[$fecha]${reset}"

    echo "${bold}${green}$ubicacion${reset}"
else
    echo "No se pudo instalar jq. Saliendo..."
    exit 1
fi


