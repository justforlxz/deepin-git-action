#!/bin/bash

repo=$1

cat >> /etc/pacman.conf << EOF
[deepingit]
Server = https://packages.justforlxz.com/
EOF
wget -qO - https://packages.justforlxz.com/deepingit.asc | pacman-key --add -
pacman-key --finger DCAF15B4605D5BEB
pacman-key --lsign-key DCAF15B4605D5BEB
pacman -Sy --noconfirm git clang pkgconfig

git clone -b packages/${repo}-git https://github.com/justforlxz/deepin-git-repo
pacman -Sy --noconfirm base-devel $(cat deepin-git-repo/PKGBUILD | grep -i "makedepends" | grep -Po '(?<=\().*(?=\))' | sed s#\'##g)
source deepin-git-repo/PKGBUILD
rm -rf deepin-git-repo
export pkgname=${GITHUB_WORKSPACE}
cd ${GITHUB_WORKSPACE}
build
