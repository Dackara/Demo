#!/usr/bin/env bash

clear
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " RTMPie LXC - Créateur de conteneur"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

# ───── PARAMÈTRES PAR DÉFAUT ─────
CTID_DEFAULT=120
HOSTNAME_DEFAULT="rtmpie"
STORAGE_DEFAULT="local-lvm"
DISK_DEFAULT="8G"
MEMORY_DEFAULT=1024
CPU_DEFAULT=2
PASSWORD_DEFAULT="admin"
REPO_URL="https://raw.githubusercontent.com/Dackara/Demo/main/Script/"

# ───── SAISIE UTILISATEUR ─────
read -p "🆔 Numéro du conteneur (CTID) [$CTID_DEFAULT] : " CTID
CTID="${CTID:-$CTID_DEFAULT}"

read -p "📛 Nom d'hôte (hostname) [$HOSTNAME_DEFAULT] : " HOSTNAME
HOSTNAME="${HOSTNAME:-$HOSTNAME_DEFAULT}"

read -p "💽 Stockage (ex: local-lvm) [$STORAGE_DEFAULT] : " STORAGE
STORAGE="${STORAGE:-$STORAGE_DEFAULT}"

read -p "📦 Taille du disque (ex: 8G) [$DISK_DEFAULT] : " DISK
DISK="${DISK:-$DISK_DEFAULT}"

read -p "🧠 RAM en Mo [$MEMORY_DEFAULT] : " MEMORY
MEMORY="${MEMORY:-$MEMORY_DEFAULT}"

read -p "🧮 Nombre de vCPU [$CPU_DEFAULT] : " CPU
CPU="${CPU:-$CPU_DEFAULT}"

read -s -p "🔑 Mot de passe root [$PASSWORD_DEFAULT] : " PASSWORD
echo
PASSWORD="${PASSWORD:-$PASSWORD_DEFAULT}"

echo -e "\n🕒 Préparation du conteneur..."

# ───── CRÉATION DU CONTENEUR ─────
pveam update
TEMPLATE=$(pveam available --section system | grep debian-12 | tail -n1 | awk '{print $1}')
pveam download local $TEMPLATE

pct create $CTID local:vztmpl/$TEMPLATE \
  --hostname $HOSTNAME \
  --storage $STORAGE \
  --cores $CPU \
  --memory $MEMORY \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp \
  --rootfs ${STORAGE}:${DISK} \
  --password $PASSWORD \
  --unprivileged 0 \
  --features nesting=1 \
  --start 1

echo -e "\n🚀 Conteneur #$CTID lancé. Installation de RTMPie..."

# ───── INSTALLATION DANS LE LXC ─────
pct exec $CTID -- apt update
pct exec $CTID -- apt install -y curl git nginx libnginx-mod-rtmp ffmpeg

# Configuration Nginx de base avec RTMP
pct exec $CTID -- bash -c 'cat > /etc/nginx/nginx.conf <<EOF
worker_processes auto;
events {}
rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            record off;
        }
    }
}
http {
    include       mime.types;
    default_type  application/octet-stream;

    server {
        listen 8080;
        location / {
            root /var/www/html;
            index index.html index.htm;
        }
    }
}
EOF'

# Interface Web minimale
pct exec $CTID -- bash -c 'mkdir -p /var/www/html && echo "<!DOCTYPE html><html lang=\"fr\"><head><meta charset=\"UTF-8\"><title>RTMPie</title></head><body><h1>🎥 Serveur RTMP prêt !</h1><p>Utilisez rtmp://<i>votre-ip</i>:1935/live comme URL de stream.</p></body></html>" > /var/www/html/index.html'

# Redémarrage Nginx
pct exec $CTID -- systemctl enable nginx
pct exec $CTID -- systemctl restart nginx

echo -e "\n✅ RTMPie installé avec succès !"
echo -e "🌐 Interface Web : http://[IP_LXC]:8080"
echo -e "📡 RTMP Input : rtmp://[IP_LXC]:1935/live"
