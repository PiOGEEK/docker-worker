# syntax=docker/dockerfile:1

FROM debian:testing

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
    ack apt-utils apt-transport-https bc bison build-essential busybox \
    ca-certificates ccache cmake cpio curl dialog file flex \
    gawk gcc-mipsel-linux-gnu git golang-go libncurses-dev \
    locales lzop mc rsync ssh sudo toilet u-boot-tools unzip vim \
    wget whiptail

RUN update-ca-certificates

RUN locale-gen --no-purge en_US.UTF-8

RUN useradd -rm -d /home/me -s /bin/bash -g root -G sudo -u 1000 me --no-log-init
RUN echo 'me:me' | chpasswd

USER me

ENV BR2_DL_DIR=/home/me/downloads

WORKDIR /home/me/thingino

RUN git config --global --add safe.directory /home/me/thingino
RUN git config --global alias.up 'pull --rebase --autostash'
