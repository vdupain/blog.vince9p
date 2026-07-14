# blog.vince9p

Blog technique personnel, généré avec [Hugo](https://gohugo.io/), hébergé sur [blog.vincentdupain.com](https://blog.vincentdupain.com/).

## Prérequis

- [Hugo](https://gohugo.io/installation/) (version extended recommandée)
- Les thèmes sont en sous-modules git

```sh
# Cloner avec les thèmes
git clone --recurse-submodules git@github.com:vdupain/blog.vince9p.git
cd blog.vince9p

# Ou mettre à jour les sous-modules si déjà cloné
git submodule update --init --recursive
```

## Développement local

```sh
# Lancer le serveur de dev avec le thème principal
hugo server -D

# Avec un thème alternatif
hugo server --config hugo-alix.toml -D
```

Le site est accessible sur `http://localhost:1313/`. L'option `-D` inclut les brouillons (articles avec `draft: true`).

## Build & déploiement

### Site principal (blog.vincentdupain.com)

```sh
hugo
```

Le site statique est généré dans le dossier `public/`.

### Déploiements spécifiques

Des scripts de déploiement existent pour différentes plateformes :

```sh
./deploy-alix.sh    # alix.home (OpenBSD httpd)
./deploy-beagle.sh  # beaglebone
./deploy-haiku.sh   # haiku
```

Chaque script utilise sa propre configuration Hugo :

| Script | Fichier de config | Cible |
|--------|------------------|-------|
| `deploy-alix.sh` | `hugo-alix.toml` | Serveur OpenBSD Alix |
| `deploy-beagle.sh` | `hugo-beagle.toml` | BeagleBone |
| `deploy-haiku.sh` | `hugo-haiku.toml` | Haiku |
| - | `hugo-hba.toml` | Non déployé par script |

## Structure

```
content/
└── posts/
    └── {slug}/
        ├── index.md     # Article
        └── images/      # Captures d'écran
```
