# lab

Docker image for data science lab. Includes GPU, Elyra, TensorFlow, and more.

## Execute

To start using the lab and connect the net port (-v) and host volume (-v):

```bash
docker run --rm -it --gpus all -p 8888:8888 -v $PWD:/home/fmind/projects fmind/lab
```
## Build

To build the environment with the default arguments:

```bash
docker build --pull --file=Dockerfile --tag=fmind/lab:latest .
```

## Push

To push the image:

```bash
docker push fmind/lab
```