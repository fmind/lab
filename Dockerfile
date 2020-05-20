FROM ubuntu:20.04

RUN apt update && \
    apt install -y git && \
    apt install -y sudo && \
    apt install -y neovim && \
    apt install -y ansible && \
    apt install -y language-pack-en

RUN useradd -m -s /bin/bash -G sudo -U fmind && \
    echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER fmind

WORKDIR /home/fmind
