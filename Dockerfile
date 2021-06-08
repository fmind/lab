# set base image
FROM tensorflow/tensorflow:latest-gpu-jupyter
# install pip packages
RUN pip3 install --no-deps --force-reinstall jupyterlab
# install git repositories
RUN rm -r /root/.jupyter
RUN git clone --depth=1 https://github.com/fmind/jupyter.d root/.jupyter
# set the default jupyter command
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
