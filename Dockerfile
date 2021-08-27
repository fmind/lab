# Use tensorflow as the base image
FROM tensorflow/tensorflow:latest-gpu
# Define the arguments of the user image
ARG NODEJS_VERSION=16.x
ARG PYTHON_VERSION=3.8
ARG USER_NAME=fmind
ARG USER_SHELL=/usr/bin/fish
# install the latest version of nodejs to build jupyterlab plugins
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION} | bash -
# install the core system packages to build the image and develop with jupyter
RUN apt update && apt install -y fish git nodejs python${PYTHON_VERSION}-dev sudo vim
# set the default system version of python and install poetry as the main dependency manager 
RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python${PYTHON_VERSION} 1 \
    && update-alternatives --set python /usr/bin/python${PYTHON_VERSION} \
    && python${PYTHON_VERSION} -m pip install poetry
# create the main user of the image, create a home directory, and grant an unlimited sudo access
RUN useradd --create-home --shell=${USER_SHELL} --groups=sudo --user-group ${USER_NAME} \
    && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV PATH="/home/fmind/.local/bin:${PATH}"
WORKDIR /home/${USER_NAME}
USER ${USER_NAME}
# define open ports
EXPOSE 8888/tcp
# define disk volumes
RUN mkdir .ssh projects
VOLUME /home/${USER_NAME}/.ssh
VOLUME /home/${USER_NAME}/projects
# install the lab dependencies
COPY --chown=${USER_NAME} poetry.lock poetry.toml pyproject.toml .
RUN poetry install --no-root # disable installation as a poetry project
# build all the jupyterlab extensions
RUN poetry run jupyter lab build --minimize=true
# clean up the installation by removing caches
RUN sudo apt clean && rm -r /home/${USER_NAME}/.cache/
# define the run command: start jupyter lab with no security token
CMD ["poetry", "run", "jupyter", "lab", "--ip=*", "--ServerApp.token=''", "--no-browser"]