[![Tuto Docker](https://github.com/user-attachments/assets/c0b881f7-0007-4f6b-a407-bf4aa053ea93)](https://youtu.be/9PzTIGc3xIM)

### Installation de Docker + Portainer + Docker Compose + Samba <br/>
> Configuration d'un conteneur LXC sous Proxmox !


## Liens pour la vidéo

►[Proxmox](https://proxmox.com) <br/>
►[Helper-Script](https://community-scripts.github.io/ProxmoxVE/) <br/>
►WebUI Portainer : `https://192.168.x.xxx:9443`

## Ligne de comande shell
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
