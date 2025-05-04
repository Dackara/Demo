#!/bin/bash

# Mise à jour et installation des dépendances nécessaires
echo "Mise à jour et installation de git, nginx..."
apt update && apt install -y git nginx

# Clonage du dépôt RTMPMonitor dans le répertoire web via SSH
echo "Clonage du dépôt RTMPMonitor..."
git clone git@github.com:phoboslab/rtmpmonitor.git /var/www/html/rtmpmonitor

# Sauvegarde de nginx.conf avant modification
echo "Sauvegarde de nginx.conf..."
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# Ajout de la configuration nécessaire pour RTMPMonitor
echo "Modification de nginx.conf..."
cat <<EOL >> /etc/nginx/nginx.conf

# Configuration pour RTMPMonitor
application live {
    live on;
    stat;
}

http {
    # Statistique de RTMP
    location /stat {
        rtmp_stat all;
        rtmp_stat_stylesheet stat.xsl;
    }

    location /stat.xsl {
        root /var/www/html/rtmpmonitor;
    }
}
EOL

# Redémarrage de Nginx pour appliquer les changements
echo "Redémarrage de Nginx..."
systemctl restart nginx

# Finalisation
echo "RTMPMonitor installé et Nginx configuré ! Accédez à http://<votre_ip>/rtmpmonitor"
