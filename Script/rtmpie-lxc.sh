#!/bin/bash

clear
echo -e "\e[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e " RTMPie LXC - Créateur de conteneur"
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m"

# ───── MENU INTERACTIF ─────
PS3="Choisissez une option : "
options=("Créer un nouveau conteneur LXC" "Quitter")
select opt in "${options[@]}"; do
    case $opt in
        "Créer un nouveau conteneur LXC")
            clear
            echo -e "\e[1;34mCréation d'un conteneur LXC pour RTMPie\e[0m"
            
            # ───── Saisie des paramètres ─────
            read -p "🆔 Numéro du conteneur (CTID) [120] : " CTID
            CTID="${CTID:-120}"

            read -p "📛 Nom d'hôte (hostname) [rtmpie] : " HOSTNAME
            HOSTNAME="${HOSTNAME:-rtmpie}"

            read -p "💽 Stockage (ex: local-lvm) [local-lvm] : " STORAGE
            STORAGE="${STORAGE:-local-lvm}"

            read -p "📦 Taille du disque (ex: 8G) [8G] : " DISK
            DISK="${DISK:-8G}"

            read -p "🧠 RAM en Mo [1024] : " MEMORY
            MEMORY="${MEMORY:-1024}"

            read -p "🧮 Nombre de vCPU [2] : " CPU
            CPU="${CPU:-2}"

            read -s -p "🔑 Mot de passe root [admin] : " PASSWORD
            echo
            PASSWORD="${PASSWORD:-admin}"

            # ───── CRÉATION DU CONTENEUR ─────
            echo -e "\n🕒 Création du conteneur LXC..."
            pveam update
            TEMPLATE=$(pveam available --section system | grep debian-12 | tail -n1 | awk '{print $1}')
            
            # Télécharger le template Debian 12
            pveam download local $TEMPLATE

            # Créer le conteneur LXC basé sur Debian 12
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

            # ───── CONFIGURATION RTMP NGINX ─────
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
            break
            ;;
        "Quitter")
            echo -e "Au revoir !"
            break
            ;;
        *)
            echo "Option invalide. Essayez à nouveau."
            ;;
    esac
done
