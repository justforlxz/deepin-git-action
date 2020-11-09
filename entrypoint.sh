#!/bin/bash

cat >> /etc/pacman.conf << EOF
[deepingit]
Server = https://packages.justforlxz.com/
EOF
wget -qO - https://packages.justforlxz.com/deepingit.asc | pacman-key --add -
pacman-key --finger DCAF15B4605D5BEB
pacman-key --lsign-key DCAF15B4605D5BEB
pacman -Syy
