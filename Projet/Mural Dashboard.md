# Mural Dashboard
Un "Dashboard murale", ou "home pannel", un écran de contrôle tactile permettant de gérer / contrôler la maison depuis un seul endroit.

## L'objectif :
- Utiliser un PC portable de tactile de 17" comme base
  - Asus X751L acheté d'occasion (~100€) avec 1To HDD
- L'installer dans le salon/séjour (coté cuisine, proche de la porte d'entrée)
  - Encastré dans la cloison, très légèrement en saillie (laiser apparaitre le contour pour le ruban de LED)
- Faire tourner le PC sous Proxmox
- Faire tourner une VM (Windows ou Linux ?) avec un Pathrough vidéo pour afficher le dashboard Home Assistant sur la VM choisi
- Profiter de Proxmox pour créer un cluster sur le serveur principal et utiliser le stockage disponible sous cette instance pour Plex ou autre.
- Récuperer le flux vidéo de la webcam et l'intégrer dans Surveillance Station (Synology)
- Utiliser capteur de mouvement et/ou de présence humaine pour passer en mode veille quand aucune activité détecté (ex: la nuit)
  - Optionnelement convertir en cadre photo multimédiat si personne n'est suffisement proche ou via un "switch"
- Créer un cadre en inpression 3D. (Bicolor : "Noir" + "Phosphorescent bleu transparent" pour laisser passer la lumière de LED placer derrière)
- Installer des capteurs (température, humidité, qualité de l'air, CO2, fumée, etc...) via un esp et ESPHome
- Créer des interface simplifié (gestion des caméra de surveillance, supervision de l'installation solaire, météo, ...)
- Utiliser un assistant vocal personnalisé (sous esphome ?) tel que "JARVIS"
