#!/bin/bash

# Recibir dos strings como argumentos (nombre de usuario y nombre del grupo).
if [ $# -ne 2 ]; then
    echo "Error ingrese el nombre de usuario y nombre de grupo"
    echo "Uso: $0 <nombre_de_usuario> <nombre_de_grupo>"
    exit 1
fi

# Almacena los nombres proporcionados como argumentos.
name_user="$1"
name_group="$2"

# Comprobar si el usuario ya existe.
if id "$name_user" &>/dev/null; then
    echo "El usuario '$name_user' ya existe."
else
    # Crear el nuevo usuario.
    sudo useradd "$name_user"
    echo "Se ha creado el usuario '$name_user'."
fi

# Comprobar si el grupo ya existe.
if grep -q "^$name_group:" /etc/group; then
    echo "El grupo '$name_group' ya existe."
else
    # Crear el nuevo grupo.
    sudo groupadd "$name_group"
    echo "Se ha creado el grupo '$name_group'."
fi

# Agregar los usuarios al grupo.
sudo usermod -aG "$name_group" "$USER"
sudo usermod -aG "$name_group" "$name_user"

echo "Se ha agregado el usuario '$USER' al grupo '$name_group'."
echo "Se ha agregado el usuario '$name_user' al grupo '$name_group'."

# Asignar permisos de ejecución al script verificador.sh solo para miembros del grupo.
sudo chown :"$name_group" verificador.sh
sudo chmod 750 verificador.sh

echo "Se han asignado permisos de ejecución para miembros del grupo '$name_group' al script 'verificador.sh'."