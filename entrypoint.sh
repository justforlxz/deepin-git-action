#!/bin/bash

repo=$1

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
build
