#!/bin/bash

repo=$1

cat >> /etc/pacman.conf << EOF

## Our main server (Amsterdam, the Netherlands) (ipv4, ipv6, http, https)
[archlinuxcn]
Server = https://repo.archlinuxcn.org/\$arch
EOF

pacman -Syyu --noconfirm archlinuxcn-keyring

git clone -b packages/${repo}-git https://github.com/justforlxz/deepin-git-repo
source deepin-git-repo/PKGBUILD
pacman -Sy --noconfirm base-devel ${depends[@]} ${makedepends[@]}
rm -rf deepin-git-repo
export pkgname=${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE}
build
