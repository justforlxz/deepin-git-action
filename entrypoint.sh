#!/bin/bash

repo=$1

cat >> /etc/pacman.conf << EOF
[deepingit]
Server = https://repo.archlinuxcn.org/$arch
EOF

pacman -Syu --noconfirm archlinuxcn-keyring
pacman -Syy

git clone -b packages/${repo}-git https://github.com/justforlxz/deepin-git-repo
pacman -Sy --noconfirm base-devel $(cat deepin-git-repo/PKGBUILD | grep -i "makedepends" | grep -Po '(?<=\().*(?=\))' | sed s#\'##g)
source deepin-git-repo/PKGBUILD
rm -rf deepin-git-repo
export pkgname=${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE}
build
