+++
title = "Installation de Lighttpd sur OpenBSD 7.7"
tags = ["homelab", "openbsd"]
date = "2025-05-22"
+++

## Installation

On installe le package **lighttpd** avec la commande OpenBSD suivante:

```sh
pkg_add lighttpd
```

Lors de l'installation du package, on choisit l'option 1 (car nous n'avons pas besoin des extensions ldap, mysql, etc...).

```sh
openbsd$ su
Password:
openbsd# pkg_add lighttpd
quirks-7.103:updatedb-0p0: ok
quirks-7.103 signed on 2025-05-20T19:48:55Z
quirks-7.103: ok
Ambiguous: choose package for lighttpd
a       0: <None>
        1: lighttpd-1.4.76p0
        2: lighttpd-1.4.76p0-ldap
        3: lighttpd-1.4.76p0-ldap-mysql
        4: lighttpd-1.4.76p0-ldap-pgsql
        5: lighttpd-1.4.76p0-mysql
        6: lighttpd-1.4.76p0-pgsql
Your choice: 1
lighttpd-1.4.76p0:lua-5.1.5p7: ok
lighttpd-1.4.76p0:spawn-fcgi-1.6.4: ok
lighttpd-1.4.76p0:bzip2-1.0.8p0: ok
lighttpd-1.4.76p0:pcre2-10.44: ok
lighttpd-1.4.76p0: ok
The following new rcscripts were installed: /etc/rc.d/lighttpd
See rcctl(8) for details.
```

On démarre le démon lighttpd:

```sh
openbsd# /etc/rc.d/lighttpd restart
lighttpd(failed)
```

Quand on démarre le démon lighttpd, on a une erreur: _lighttpd(failed)_. On vérifie dans les logs pour en savoir un peu plus:

```sh
openbsd# cat /var/www/logs/error.log
2025-05-21 19:39:21: (/pobj/lighttpd-1.4.76/lighttpd-1.4.76/src/configfile.c.1824) opening /dev/null failed: No such file or directory
2025-05-21 19:39:21: (/pobj/lighttpd-1.4.76/lighttpd-1.4.76/src/server.c.1935) Opening errorlog failed. Going down.
```

En fait, c'est "une erreur normale" car le processus **lighttpd** est chrooté: c'est à dire que le répertoire racine du processus est modifé pour remplacer la racine par défaut **_/_** (root) par un autre répertoire (**_/var/www_** dans le cas présent).

D'où le nom de la commande **chroot** (change roo ou changer la racine en français).

Mais il n'existe pas de fichier **_/dev/null_** dans le répertoire _**/var/www/**_, ce qui cause l'erreur au démarrage du démon lighttpd.

D'ailleurs on retrouve la configuration du chroot dans le fichier de configuration de lighttpd qui se trouve ici: _/etc/lighttpd.conf_

```sh
openbsd# grep "chroot" /etc/lighttpd.conf
# chroot() to directory
server.chroot              = "/var/www/"
```

Pour résoudre ce problème, nous devons simplement créer le fichier manquant:

```sh
cd /var/www/
mkdir dev
mknod dev/null c 2 2
chmod 666 dev/null
```

On vérifie que le fichier manquant est bien présent:

```sh
openbsd# ls -l /var/www/dev/null
crw-rw-rw-  1 root  daemon  2, 2 May 21 21:16 /var/www/dev/null
```

Et on redémarre le démon lighttpd

```sh
openbsd# /etc/rc.d/lighttpd restart
lighttpd(ok)
```

Si on vérifie dans les logs, on peut voir que le processus est bien démarré:

```sh
openbsd# cat /var/www/logs/error.log
2025-05-21 19:39:21: (/pobj/lighttpd-1.4.76/lighttpd-1.4.76/src/configfile.c.1824) opening /dev/null failed: No such file or directory
2025-05-21 19:39:21: (/pobj/lighttpd-1.4.76/lighttpd-1.4.76/src/server.c.1935) Opening errorlog failed. Going down.
2025-05-21 21:17:38: (/pobj/lighttpd-1.4.76/lighttpd-1.4.76/src/server.c.1939) server started (lighttpd/1.4.76)
```

> Comme on peut le constater, la journalisation du message de démarrage en succès de lighttpd est dans le fichier de logs d'erreur!

Maintenant que c'est ok, on active le démon lighttpd pour qu'il soit actif au démarrage de la machine.

```sh
rcctl enable lighttpd
```

## Configuration

En raison de l'utilisation du chroot, il faut modifier la configuration _/etc/lighttpd.conf_ et modifier le paramètre **server.document-root**.

En effet les chemins sont relatifs, on doit donc ajouter le caractère "**/**" devant **_htdocs/_** car **_htdocs/_** en chroot correspond bien à **_/var/www/htdocs/_**.

```sh
openbsd# grep "server.document-root" /etc/lighttpd.conf
server.document-root        = "/htdocs/"
```

## Vérification

On crée une page html et on fera un appel avec curl pour vérifier.

```sh
echo "Hello !" > /var/www/htdocs/index.html
```

```sh
openbsd# cat /var/www/htdocs/index.html
Hello !
```

On vérifie que le démon lighttpd nous renvoie bien notre page html et donc qu'il accède bien au répertoire **_htdocs/_**:

```sh
openbsd# curl -v localhost
* Host localhost:80 was resolved.
* IPv6: ::1
* IPv4: 127.0.0.1
*   Trying [::1]:80...
* Connected to localhost (::1) port 80
* using HTTP/1.x
> GET / HTTP/1.1
> Host: localhost
> User-Agent: curl/8.13.0
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: text/html
< ETag: "391545070"
< Last-Modified: Wed, 21 May 2025 19:38:57 GMT
< Content-Length: 8
< Accept-Ranges: bytes
< Date: Wed, 21 May 2025 19:46:44 GMT
< Server: lighttpd/1.4.76
<
Hello !
* Connection #0 to host localhost left intact
```

Tout est ok et lighttpd fonctionne correctement pour service des pages html statiques.

> Ne pas oublier d'installer curl (pkg_add curl) qui n'est pas présent par défaut dans OpenBSD

## Pour aller plus loin

- [OpenBSD](https://www.openbsd.org/index.html)
- [lighttpd](https://www.lighttpd.net/)
