# set base image
FROM tensorflow/tensorflow:latest-gpu
# install node setup
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
# install system packages
RUN apt update && apt install -y ansible git neovim nodejs python3-dev sudo
# create main user
RUN echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd -m -s /bin/bash -G sudo -U fmind
WORKDIR /home/fmind
USER fmind
# define port exposes
EXPOSE 8888/tcp
# define mount volumes
VOLUME /home/fmind/.ssh
VOLUME /home/fmind/.gnupg
VOLUME /home/fmind/notebooks
# install git repository
RUN git clone --depth=1 https://github.com/fmind/devfiles
RUN cd devfiles && ansible-playbook site.yml --tags "pre,jupyter,tensorflow"
# define default run command
WORKDIR /home/fmind/notebooks
ENV PATH="/home/fmind/.local/bin:${PATH}"
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--ServerApp.token=''", "--no-browser"]
