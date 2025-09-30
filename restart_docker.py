import subprocess
import time
import requests
from datetime import datetime

# Configuración del bot de Telegram
BOT_TOKEN = "XXXX"  # Reemplaza con tu token de bot
CHAT_ID = "XXXX"       # Reemplaza con tu ID de chat


# Nombre del contenedor Docker
CONTAINER_NAME = "homeassistant"

# Archivo de log
LOG_FILE = "/home/kali/Documents/scripts/logs/restart_docker.log"  # Ruta del archivo de log

def log_message(message, param):
    """Escribe un mensaje en el archivo de log con la fecha y hora actual."""
    """Con param discriminamos si enviamos a Telegram el mensaje"""
    timestamp = datetime.now().strftime("%d-%m-%Y %H:%M:%S")
    with open(LOG_FILE, "a") as log:
        log.write(f"[{timestamp}] {message}\n")
    
    if param == 1: 
        message = timestamp + " -->> " + message + "."
        send_telegram_message(BOT_TOKEN, CHAT_ID, message) # Envia el mensaje a Telegram


def is_container_running(container_name):
    """Comprueba si el contenedor está en ejecución."""
    result = subprocess.run(
        ["docker", "inspect", "-f", "{{.State.Running}}", container_name],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    return "true" in result.stdout

def stop_container(container_name):
    """Detiene el contenedor."""
    result = subprocess.run(
        ["docker", "stop", container_name],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    return result.returncode == 0

def start_container(container_name):
    """Inicia el contenedor."""
    result = subprocess.run(
        ["docker", "start", container_name],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    return result.returncode == 0

def send_telegram_message(bot_token, chat_id, message):
    """Envía un mensaje a Telegram."""
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    params = {
        "chat_id": chat_id,
        "text": message,
        "parse_mode": "HTML"
    }
    response = requests.post(url, data=params)
    if response.status_code != 200:
        log_message(f"Error al enviar el mensaje: {response.status_code}",0)
        log_message(str(response.json()))

def main():
    log_message(f"Inicio del proceso de reinicio del contenedor '{CONTAINER_NAME}'",1)
    # Comprobar si el contenedor está en ejecución
    running = is_container_running(CONTAINER_NAME)
    if running:
        log_message(f"El contenedor '{CONTAINER_NAME}' está en ejecución. Deteniendo...",0)
        if stop_container(CONTAINER_NAME):
            log_message(f"El contenedor '{CONTAINER_NAME}' se ha detenido correctamente.",0)
        else:
            log_message(f"Error al detener el contenedor '{CONTAINER_NAME}'.",1)
            return

    # Esperar 10 segundos
    log_message("Esperando 10 segundos...",0)
    time.sleep(10)

    # Reiniciar el contenedor
    log_message(f"Iniciando el contenedor '{CONTAINER_NAME}'...",0)
    if start_container(CONTAINER_NAME):
        log_message(f"El contenedor '{CONTAINER_NAME}' se ha iniciado correctamente.",0)

        # Enviar mensaje a Telegram
        message = "Proceso completado satisfactoriamente. FIN."
        send_telegram_message(BOT_TOKEN, CHAT_ID, message)
    else:
        log_message(f"Error al iniciar el contenedor '{CONTAINER_NAME}'.",1)

if _name_ == "_main_":
    # Me aseguro que el directorio de logs exista
    import os
    os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

    main()