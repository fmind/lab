# set base image
FROM tensorflow/tensorflow:latest-gpu-jupyter
# install nodejs setup
RUN wget -qO- https://deb.nodesource.com/setup_14.x | bash -
# install system packages
RUN apt update && apt install -y git nodejs python3-dev build-essenbial
# install git repositories 
RUN git clone --depth=1 https://github.com/fmind/devfiles
RUN cd devfiles && ansible-playbook -i inventory.ini site.yml --tag jupyter --tag tensorflow
# set the default lab command
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
