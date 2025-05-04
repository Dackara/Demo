#!/bin/bash

# Met à jour le système
apt update && apt upgrade -y

# Installe les dépendances système
apt install -y curl git nginx libnginx-mod-rtmp ffmpeg python3-pip python3-venv

# Installe RTMPie
cd /opt
git clone https://github.com/rtmpie/rtmpie.git
cd rtmpie
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Installe RTMPie comme service
cp systemd/rtmpie.service /etc/systemd/system/
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable rtmpie
systemctl start rtmpie

# Configure nginx avec RTMP et stat page
cat > /etc/nginx/nginx.conf <<EOF
worker_processes  auto;
events { worker_connections 1024; }

rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            record off;
        }

        # Statistiques NGINX RTMP
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

# Télécharge la feuille de style stat.xsl
curl -o /usr/share/nginx/html/stat.xsl https://raw.githubusercontent.com/arut/nginx-rtmp-module/master/stat.xsl

# Crée une page web de test
echo "<h1>RTMPie est installé</h1>" > /var/www/html/index.html

# Redémarre nginx
systemctl enable nginx
systemctl restart nginx

echo "✅ Installation terminée !"
echo "🌐 Page web : http://[IP]:8080"
echo "📊 Statistiques RTMP : http://[IP]:8080/stat"
echo "📡 RTMP URL : rtmp://[IP]:1935/live"
