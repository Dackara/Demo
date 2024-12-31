[![Tuto rClone](https://github.com/user-attachments/assets/459ce645-20ac-4506-9d39-155d4d3b49f4)](https://youtu.be/3vzVOd-yQks)

### Installation de rClone + Samba <br/>
> Configuration d'un conteneur LXC sous Proxmox !


## Liens pour la vidéo

►[Proxmox](https://proxmox.com) <br/>
►[Helper-Script](https://community-scripts.github.io/ProxmoxVE/) <br/>
►[rClone](https://rclone.org/) <br/>
►WebUI rClone : `https://192.168.x.xxx:5572`

## Ligne de comande shell
**Installation de rClone :**
```
sudo -v ; curl https://rclone.org/install.sh | sudo bash
rclone rcd --rc-web-gui --rc-web-gui-no-open-browser & 
sudo apt -y install fuse3
```

**Création de l'automatisation du démarrage du WebUI :**
```
mkdir -p /etc/systemd/system
nano /etc/systemd/system/rclone_gui.service
```

**Dans le fichier, on ajoute les ligne :**
```
[Unit]
Description=rclone GUI
After=networking.service

[Service]
Type=simple
ExecStart=rclone rcd --rc-web-gui --rc-addr :5572 --rc-user <user_name> --rc-pass <password> --rc-web-gui-no-open-browser
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
```
*En remplacent `<user_name>` et  `<password>` par les votres.*

**Activation de l'automatisme :**
```
systemctl enable rclone_gui.service
systemctl start rclone_gui.service
```

**Pour trouver l'IP :**
```
ip a
```

**Installation de Samba :**
```
apt install samba
```

**Edition du fichier de configuaration :**
```
sudo nano /etc/samba/smb.conf
```

**En bas du fichier, on ajoute les ligne :**
```
[*nom_du_partage*]
    comment = Samba on Debian
    path = ./
    read only = no
    browsable = yes
    admin users = *Dackara*
```

*En remplacent les partie entre asterix ```*```.*

**Ensuite :**
```
sudo service smbd restart
sudo adduser *Dackara* --allow-bad-names
sudo smbpasswd -a *Dackara*
pdbedit -w -L
```

またね Matane !
