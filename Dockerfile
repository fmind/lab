FROM tensorflow/tensorflow:latest-gpu-jupyter

RUN apt update && apt install -y git htop ncdu wget 

RUN wget -qO- https://deb.nodesource.com/setup_14.x | bash -

RUN apt update && apt install -y nodejs python3-dev build-essential

RUN rm -rf ~/.jupyter && git clone --depth=1 https://github.com/fmind/jupyter.d ~/.jupyter

RUN python3 -m pip install RISE voila jupytext papermill ipywidgets ipyparallel jupyterlab nteract-scrapbook 

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
