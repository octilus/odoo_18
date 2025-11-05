#!/bin/bash

MODELS_DIR="models"

if [ ! -d "$MODELS_DIR" ]; then
    echo "❌ Carpeta 'models/' no encontrada. Ejecuta desde facilsoft_theme_backend/."
    exit 1
fi

echo "🔍 Verificando y corrigiendo indentación en archivos de models/..."

for file in "$MODELS_DIR"/*.py; do
    if [[ ! -f "$file" ]]; then
        continue
    fi

    # Verifica si hay líneas _name sin indentación correcta
    if grep -q "^[^ ]*_name = " "$file" 2>/dev/null; then
        echo "🔧 Corrigiendo indentación en: $(basename "$file")"
        # Reemplaza cualquier línea _name que no empiece con 4 espacios
        sed -i.bak '/_name = /{
            s/^[[:space:]]*/    /
        }' "$file"
    elif grep -q "^[[:space:]]\{0,3\}_name = " "$file" 2>/dev/null; then
        echo "🔧 Corrigiendo indentación insuficiente en: $(basename "$file")"
        sed -i.bak '/_name = /{
            s/^[[:space:]]*/    /
        }' "$file"
    fi
done

echo ""
echo "✅ Verificación completada. Todas las líneas '_name' ahora tienen 4 espacios."
echo "ℹ️  Copias de seguridad (.bak) se guardaron por si necesitas revertir."