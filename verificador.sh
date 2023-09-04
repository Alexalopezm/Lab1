#!/bin/bash

# Se comprueba que se proporciona un argumento llamado enunciado

if [$# -ne 1]; then
	echo "Uso: $0 <enunciado.pdf>"
	exit 1
fi

# Almacenar el nombre en un argumento
name="$1"

# Verificar si el archivo existe
if [ -e "$file_name" ]; then
	# Obtener los permisos del archivo
	permissions=$(stat -c "%A" "$name")

	# Define una funcion para obtener los permisos
	get_permissions_verbose() {
		local perm_string="$1"
		local user_perms="${perm_string:1:3}"
		local group_perms="${perm_string:4:3}"
		local others_perms="${perm_string:7:3}"
		
		# Compara los permisos de lectura del usuario
		if [ "${user_perms:0:1}" == "r" ]; then
			echo "El usuario tiene permisos de lectura"
		else
			echo "El usuario no tiene permisos de lectura"
		fi

		# Compara los permisos de escritura del usuario
		if [ "${user_perms:1:1}" == "w" ]; then
			echo "El grupo tiene permisos de escritura"
		else
			echo "El grupo no tiene permisos de escritura"
		fi

		# Compara los permisos de ejecutar del usuario
		if [ "${user_perms:2:1}" == "x" ]; then
			echo "El grupo tiene permisos de ejecutar"
		else
			echo "El grupo no tiene permisos de ejecutar"
		fi
	}

	# Se llama a la funcion
	get_permissions_verbose "$permissions"
else
	echo "El archivo '$enunciado' no existe."
	exit 2
fi

exit 0

