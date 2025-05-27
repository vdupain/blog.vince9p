+++
title = "Bye bye Oh My Zsh, retour à bash et powerline.bash "
tags = ["unix"]
date = "2025-05-27"
draft = true
+++

Pourquoi supprimer **Oh My Zsh**?

- je suis très loin d'utiliser toutes fonctionnalités de zsh/oh-my-zsh
- je trouve que c'est un peu l'usine à gaz
- je suis partisant du minimaliste et d'utiliser autant que possible les outils/fonctionnalités déjà installés sur les sytèmes d'exploitation

On supprime donc **Oh My Zsh**, pour cela on exécute la commande suivante en ligne de commande depuis un shell **oh-my-zsh**:

```sh
uninstall_oh_my_zsh
```

Et là on revient à un autre shell, on choisira **bash**.

Ensuite on va installer [powerline.bash](https://gitlab.com/bersace/powerline.bash) pour enrichir quand même de quelques fonctionnaliés suplémentaires.

Pour installer [powerline.bash](https://gitlab.com/bersace/powerline.bash):

```sh
curl -Lo ~/.config/powerline.bash https://gitlab.com/bersace/powerline-bash/raw/master/powerline.bash
. ~/.config/powerline.bash
PROMPT_COMMAND='__update_ps1 $?
```

Ensuite il faut ajouter la configuration suivante dans votre fichier _.bashrc_ pour activer powerline.bash:

```sh
. ${HOME}/.config/powerline.bash
PROMPT_COMMAND='__update_ps1 $?'
```

Recharger shell bash:

- soit avec ```exec $SHELL```
- soit en sourcant le fichier _.bashrc_: ```. .bashrc```

## Références

- [powerline.bash](https://gitlab.com/bersace/powerline.bash)
- [powerline-shell](https://github.com/b-ryan/powerline-shell)
- [Uninstalling Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#uninstalling-oh-my-zsh)
