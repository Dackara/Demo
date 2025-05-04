#!/bin/bash

set -e

echo "🔄 Mise à jour du système..."
apt update && apt upgrade -y

echo "📦 Installation des dépendances..."
apt install -y curl git nginx libnginx-mod-rtmp ffmpeg python3-pip python3-venv

echo "📁 Clonage du dépôt RTMPie..."
cd /opt
git clone https://github.com/ngrie/rtmpie.git
cd rtmpie

echo "🐍 Configuration de l'environnement virtuel Python..."
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo "🔧 Installation de RTMPie comme service systemd..."
cp systemd/rtmpie.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable rtmpie
systemctl start rtmpie

echo "📝 Configuration de Nginx avec RTMP + stat page..."
cat > /etc/nginx/nginx.conf <<EOF
worker_processes auto;
events { worker_connections 1024; }

rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            record off;
        }

        application statapp {
            live on;
        }
    }
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    server {
        listen 8080;

        location /stat {
            rtmp_stat all;
            rtmp_stat_stylesheet stat.xsl;
        }

        location /stat.xsl {
            root /usr/share/nginx/html;
        }

        location / {
            root /var/www/html;
            index index.html;
        }
    }
}
EOF

echo "🌐 Téléchargement de la feuille de style stat.xsl..."
curl -o /usr/share/nginx/html/stat.xsl https://raw.githubusercontent.com/arut/nginx-rtmp-module/master/stat.xsl

echo "🌍 Création d'une page web d'accueil simple..."
echo "<h1>RTMPie est installé</h1>" > /var/www/html/index.html

echo "🚀 Redémarrage de Nginx..."
systemctl enable nginx
systemctl restart nginx

echo "✅ Installation terminée avec succès !"
echo "--------------------------------------------"
echo "🌐 Interface Web : http://[IP]:8080"
echo "📊 Statistiques RTMP : http://[IP]:8080/stat"
echo "📡 RTMP URL : rtmp://[IP]:1935/live"
