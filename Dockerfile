# set base image
FROM tensorflow/tensorflow:latest-gpu
# install node setup
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
# install system packages
RUN apt update && apt install -y fish git nodejs python3-dev sudo
# create main user in sudo group
RUN echo "fmind ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd -m -s /bin/bash -G sudo -U fmind
WORKDIR /home/fmind
USER fmind
# define exposed ports
EXPOSE 8888/tcp
# define disk volumes
VOLUME /home/fmind/.ssh
VOLUME /home/fmind/.gnupg
VOLUME /home/fmind/notebooks
# additional config
RUN pip3 freeze > requirements.lock.txt
RUN jupyter lab build
# define default run command
WORKDIR /home/fmind/notebooks
ENV PATH="/home/fmind/.local/bin:${PATH}"
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--ServerApp.token=''", "--no-browser"]
