#!/bin/bash

# Carpeta de modelos
MODELS_DIR="models"

# Verifica que exista
if [ ! -d "$MODELS_DIR" ]; then
    echo "❌ Carpeta 'models/' no encontrada. Ejecuta este script dentro de facilsoft_theme_backend/."
    exit 1
fi

# Procesa cada archivo .py en models/
for file in "$MODELS_DIR"/*.py; do
    if [[ ! -f "$file" ]]; then
        continue
    fi

    filename=$(basename "$file" .py)

    # Define el nuevo _name basado en el nombre del archivo
    # Ej: bookmark.py → facilsoft.bookmark
    #     backend_configurator.py → facilsoft.backend.configurator
    new_name="facilsoft.$filename"
    new_name=${new_name//_/.}  # Reemplaza guiones bajos por puntos

    echo "🔧 Procesando: $file → _name = '$new_name'"

    # Usa sed para reemplazar la línea _name = '...'
    # Solo toca líneas que contengan "_name = '"
    sed -i.bak "/_name = '/c\_name = '$new_name'" "$file"
done

echo ""
echo "✅ Todos los archivos en 'models/' han sido actualizados."
echo "ℹ️  Copias de seguridad (.bak) se crearon por si necesitas revertir."