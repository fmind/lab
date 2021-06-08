# set base image
FROM tensorflow/tensorflow:latest-gpu-jupyter
# set the default jupyter command
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip=0.0.0.0 --NotebookApp.token='' --no-browser --allow-root"]
