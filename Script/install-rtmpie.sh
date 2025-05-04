#!/bin/bash
set -e

echo "🔄 Mise à jour du système..."
apt update && apt upgrade -y

echo "📦 Installation des dépendances nécessaires pour la compilation..."
apt install -y curl git libnginx-mod-rtmp ffmpeg python3-pip python3-venv \
    build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev

echo "📁 Clonage du dépôt RTMPie..."
cd /opt
git clone https://github.com/ngrie/rtmpie.git
cd rtmpie

echo "🐍 Configuration de l'environnement virtuel Python..."
python3 -m venv venv
source venv/bin/activate
pip install flask flask-socketio

echo "🔧 Installation de Nginx avec le module RTMP..."
cd /usr/local/src
# Télécharger Nginx
wget http://nginx.org/download/nginx-1.24.0.tar.gz
tar -zxvf nginx-1.24.0.tar.gz
cd nginx-1.24.0
# Télécharger et ajouter le module RTMP
git clone https://github.com/arut/nginx-rtmp-module.git
# Compiler Nginx avec le module RTMP
./configure --add-module=./nginx-rtmp-module
make
make install

echo "🔧 Création du service systemd pour RTMPie..."
cat > /etc/systemd/system/rtmpie.service <<EOF
[Unit]
Description=RTMPie Web Interface
After=network.target

[Service]
WorkingDirectory=/opt/rtmpie
ExecStart=/opt/rtmpie/venv/bin/python3 app.py
Restart=always
User=root
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable rtmpie
systemctl start rtmpie

echo "📝 Configuration de Nginx avec RTMP + page stat..."
cat > /usr/local/nginx/conf/nginx.conf <<EOF
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
mkdir -p /var/www/html
echo "<h1>✅ RTMPie est installé avec succès</h1>" > /var/www/html/index.html

echo "🚀 Démarrage de Nginx..."
/usr/local/nginx/sbin/nginx

echo "🚀 Redémarrage des services..."
systemctl restart nginx

echo ""
echo "✅ Installation terminée avec succès !"
echo "--------------------------------------------"
echo "🌐 Interface Web RTMPie : http://[IP_DE_TON_LXC]:5000"
echo "📊 Statistiques RTMP    : http://[IP_DE_TON_LXC]:8080/stat"
echo "📡 Flux RTMP (entrée)   : rtmp://[IP_DE_TON_LXC]:1935/live"
