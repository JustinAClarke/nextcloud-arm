    A Nextcloud Docker Container for armhf
    Copyright (C) 2017  Justin Furhemister-Clarke

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

---

You can either build this with `./build` or if you choose to grab this directly from docker with
`docker run -it jfuhrmie/nextcloud-arm` both with work  

---

NOTE:
Only run `./build.sh` on an armhf machine, if you run this on a x86_64 system it will fail

---

## Cloned from Nextcloud/Docker

---

What is Nextcloud?

A safe home for all your data. Access & share your files, calendars, contacts, mail & more from any device, on your terms.

![logo](https://github.com/nextcloud/docker/raw/master/logo.png)

# How to use this image
This image is designed to be used in a micro-service environment. It consists of the Nextcloud installation in an [php-fpm](https://hub.docker.com/_/php/) container. To use this image it must be combined with any webserver that can proxy the http requests to the FastCGI-port of the container.

## Start Nextcloud

Starting Nextcloud php-fpm instance listening on port 9000 is as easy as the following:

```console
$ docker run -d jfuhrmie/nextcloud-arm
```

Now you can get access to fpm running on port 9000 inside the container. If you want to access it from the internet, we recommend using a reverse proxy in front. You can install it directly on your machine or use an additional container (You can find more information on that on the docker-compose section). Once you have a reverse proxy, you can access Nextcloud at http://localhost/ and go through the wizard. 

By default this container uses SQLite for data storage, but the Nextcloud setup wizard (appears on first run) allows connecting to an existing MySQL/MariaDB or PostgreSQL database. You can also link a database container, e.g. `--link my-mysql:mysql`, and then use `mysql` as the database host on setup.

## Persistent data

All data beyond that which lives in the database (file uploads, etc) is stored within the default volume `/srv/http/nextcloud`. With this volume, Nextcloud will only be updated when the file `version.php` is not present.

- `-v /<mydatalocation>:/srv/http/nextcloud`

For fine grained data persistence, you can use 3 volumes, as shown below.

- `-v /<mydatalocation>/apps:/srv/http/nextcloud/apps` installed / modified apps
- `-v /<mydatalocation>/config:/srv/http/nextcloud/config` local configuration
- `-v /<mydatalocation>/data:/srv/http/nextcloud/data` the actual data of your Nextcloud

## ... via [`docker-compose`](https://github.com/docker/compose)

The recommended minimal setup is using this image in combination with two containers: A database container and a reverse proxy for the http connection to the service.
A working example can be found at [jfuhrmie/nextcloud-arm](https://github.com/jfuhrmie/nextcloud-arm).

If you want to access your Nextcloud from the internet we recommend configuring your reverse proxy to use encryption (for example via [let's Encrypt](https://letsencrypt.org/))

## Update to a newer version

To update your Nextcloud version you simply have to pull and start the new container.
```console
$ docker pull jfuhrmie/nextcloud-arm
$ docker run -d jfuhrmie/nextcloud-arm
```
When you access your site the update wizard will show up.
