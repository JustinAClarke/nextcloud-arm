#!/bin/bash
set -e

if [ $# -ne 2 ] ; then
	echo "Usage: ./update.sh <caddy tag or branch> <nextcloud branch>"
	exit
fi

export NEXTCLOUD=$2
export VERSION=$1

# cd to the current directory so the script can be run from anywhere.
cd `dirname $0`

echo "Fetching CaddyServer $VERSION..."
wget -O caddy_linux_arm_custom.tar.gz https://github.com/mholt/caddy/releases/download/$VERSION/caddy_linux_arm7.tar.gz
tar -xf caddy_linux_arm_custom.tar.gz


wget https://nextcloud.com/nextcloud.asc; gpg --import nextcloud.asc

wget https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD.tar.bz2; wget https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD.tar.bz2.md5
wget https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD.tar.bz2.asc; gpg --verify nextcloud-$NEXTCLOUD.tar.bz2.asc nextcloud-$NEXTCLOUD.tar.bz2

md5sum -c nextcloud-$NEXTCLOUD.tar.bz2.md5 < nextcloud-$NEXTCLOUD.tar.bz2

gpg --verify nextcloud-$NEXTCLOUD.tar.bz2.asc nextcloud-$NEXTCLOUD.tar.bz2
tar -xf nextcloud-$NEXTCLOUD.tar.bz2

echo "Replace $VERSION in Dockerfiles..."
envsubst < Dockerfile.tmpl > Dockerfile

rm nextcloud.asc nextcloud-$NEXTCLOUD.tar.bz2 nextcloud-$NEXTCLOUD.tar.bz2.asc caddy_linux_arm_custom.tar.gz nextcloud-$NEXTCLOUD.tar.bz2.md5

echo "Done."
