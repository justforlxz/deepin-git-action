FROM archlinux:latest

RUN pacman-key --init
RUN pacman -Sy --noconfirm wget

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
