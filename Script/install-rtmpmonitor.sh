#!/bin/bash

# Téléchargement du script d'installation depuis GitHub
echo "Téléchargement du script d'installation depuis GitHub..."
curl -fsSL https://raw.githubusercontent.com/Dackara/Demo/main/Script/install-rtmpmonitor.sh -o /tmp/install-rtmpmonitor.sh

# Rendre le script exécutable
chmod +x /tmp/install-rtmpmonitor.sh

# Exécution du script
echo "Exécution du script d'installation..."
/tmp/install-rtmpmonitor.sh

# Suppression du script temporaire
rm /tmp/install-rtmpmonitor.sh

echo "Installation terminée avec succès !"
