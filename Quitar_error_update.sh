#!/bin/bash


#Primero, descarga la clave GPG del repositorio oficial de Kali Linux usando wget:
wget https://archive.kali.org/archive-key.asc

#Ejecuta el siguiente comando para importar la clave GPG:
gpg --dearmor < archive-key.asc | sudo tee /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg > /dev/null
#Este comando convierte la clave en formato binario (necesario para APT) y la guarda en el directorio correcto. 

