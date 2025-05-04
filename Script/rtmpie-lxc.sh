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
REPO_URL="https://raw.githubusercontent.com/tonutilisateur/proxmox-rtmpie-lxc/main"

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
pct exec $CTID -- apt install -y curl git

pct exec $CTID -- curl -fsSL $REPO_URL/install-inside-lxc.sh -o /root/install-inside-lxc.sh
pct exec $CTID -- chmod +x /root/install-inside-lxc.sh
pct exec $CTID -- /root/install-inside-lxc.sh

echo -e "\n✅ Installation terminée !"
echo -e "🌐 Accède à l'interface via : http://[IP_du_LXC]:8080 (admin / admin)"
