!# /bin/bash

sudo find / -type f -exec du -b {} + 2>/dev/null | awk '{ if ($1 > 536870912) print $1, $2 }' | sort -nr | awk '{ $1 = $1 / 1073741824 " GB"; print }'

Explicación detallada  

    sudo find / -type f : 
        Busca todos los archivos (-type f) en todo el sistema (/).
        Usa sudo para asegurarte de tener permisos para acceder a todos los directorios.
         

    -exec du -b {} + : 
        Para cada archivo encontrado, usa el comando du -b para obtener su tamaño en bytes.
        {} es un marcador que representa el archivo actual procesado por find.
        El + al final permite agrupar múltiples archivos en una sola llamada a du, lo que mejora la eficiencia.
         

    2>/dev/null : 
        Redirige los mensajes de error (como "permiso denegado") a /dev/null para evitar que se muestren en la salida.
         

    awk '{ if ($1 > 536870912) print $1, $2 }' : 
        Filtra los archivos cuyo tamaño sea mayor a 0.5 GB (536870912 bytes).
        $1 es el tamaño en bytes, y $2 es la ruta del archivo.
        Solo imprime los archivos que cumplen con el criterio.
         

    sort -nr : 
        Ordena la lista numéricamente (-n) en orden descendente (-r), es decir, desde el archivo más grande hasta el más pequeño.
         

    awk '{ $1 = $1 / 1073741824 " GB"; print }' : 
        Convierte el tamaño de bytes a gigabytes dividiendo entre 1073741824 (1 GB = 1073741824 bytes).
        Añade la etiqueta "GB" al tamaño.
         
     
