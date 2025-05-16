+++
title = "Comment démarrer un OS depuis le réseau en PXE avec netboot.xyz"
tags = ["homelab"]
date = "2025-05-16"
draft = true
+++

## Netboot PXE

## Configuration OPNSense

Avant toute chose, il faut un serveur DHCP et un serveur TFTP.
Chez moi j'utilise OPNSense, on va donc voir comment les configurer pour pourvoir ensuite amorcer un OS depuis le réseau.

### Installation et configuration du serveur TFTP

Il n'y a pas de serveur TFTP installé par défaut dans OPNSense, nous devons donc l'installer et cela passe par l'installation d'un plugin.

- Aller dans le menu "**System > Firmware > Plugin**"
- recherche le plugin qui se nomme **os-tftp**
- cliquer sur le bouton "**+**" pour installer ce plugin

Une fois le plugin **os-tftp** installé, il faut encore réaliser quelques opérations:
On se connecte à OPNSense pour créer le répertoire nécessaire pour TFTP.

```sh
ssh root@opnsense
mkdir /usr/local/tftp
cd /usr/local/tftp
```

Ensuite nous devons télécharger les fichiers netboot dans le répertoire crée précédemment

```sh
curl https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe
curl https://boot.netboot.xyz/ipxe/netboot.xyz.efi
curl https://boot.netboot.xyz/ipxe/netboot.xyz-arm64.efi
```

### Configuration du serveur DHCP

## Démarrer une VM en PXE dans Proxmox

## Démarrer OpenBSD depuis une carte Alix 2D3

## Conclusion

## Pour aller plus loin

* <https://netboot.xyz/>

