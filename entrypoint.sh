#!/bin/bash

repo=$1
BUILD_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
TELEGRAM_BOT_KEY="1574643767:AAFRHeh590So5EVFYnwLn8l3Va3rVAUlz0M"

function send_message() {
    curl https://api.telegram.org/bot${TELEGRAM_BOT_KEY}/sendMessage?chat_id=@deepingitnews&text=$repo+\ +$BUILD_URL
}

cat >> /etc/pacman.conf << EOF

## Our main server (Amsterdam, the Netherlands) (ipv4, ipv6, http, https)
[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOF

pacman -Syyu --noconfirm archlinuxcn-keyring

git clone -b packages/${repo}-git https://github.com/justforlxz/deepin-git-repo
pacman -Sy --noconfirm base-devel $(cat deepin-git-repo/PKGBUILD | grep -i "makedepends" | grep -Po '(?<=\().*(?=\))' | sed s#\'##g)
source deepin-git-repo/PKGBUILD
rm -rf deepin-git-repo
export pkgname=${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE}
build || send_message
