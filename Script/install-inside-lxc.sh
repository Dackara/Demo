#!/bin/bash
set -e

echo "🔧 Mise à jour du système..."
apt update && apt upgrade -y

echo "🔧 Installation des dépendances : nginx, nodejs, mongodb, git..."
apt install -y nginx libnginx-mod-rtmp mongodb git curl build-essential

echo "🔧 Installation de Node.js LTS via 'n'..."
npm install -g n
n lts

echo "📁 Clonage de RTMPie dans /opt/rtmpie..."
cd /opt
git clone https://github.com/ngrie/rtmpie.git
cd rtmpie

echo "📦 Installation des dépendances Node.js..."
npm install

echo "🛠 Configuration de RTMPie..."
cp config.example.json config.json

echo "🔧 Configuration de NGINX avec le module RTMP..."
cat > /etc/nginx/nginx.conf <<CONF
worker_processes auto;
events { worker_connections 1024; }

rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            record off;
            on_publish http://localhost:8080/api/hooks/on_publish;
            on_publish_done http://localhost:8080/api/hooks/on_publish_done;
        }
    }
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen 80;
        location / {
            return 200 "RTMP Server is running\n";
        }
    }
}
CONF

echo "🔁 Redémarrage de NGINX..."
systemctl restart nginx

echo "🔧 Création du service systemd pour RTMPie..."
cat > /etc/systemd/system/rtmpie.service <<SERVICE
[Unit]
Description=RTMPie Web Interface
After=network.target mongodb.service

[Service]
ExecStart=/usr/local/bin/node /opt/rtmpie/index.js
WorkingDirectory=/opt/rtmpie
Restart=always
User=root
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
SERVICE

echo "🔁 Activation du service RTMPie..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable --now rtmpie

echo "✅ Interface accessible sur http://[IP_LXC]:8080 (admin/admin)"
