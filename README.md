# Create a Docker Image with a conda environment for scRNA-seq data analysis

## How it works

The ```Dockerfile``` creates a Docker Image on Debian and installs miniconda. After, it creates a virtual environment called sc-env from the ```environment.ylm``` file and install some extra R packages from the ```install_r_packages.R``` file.

The full list of the Python and R packages installed is saved within the docker image in ```spec-conda-file.txt``` , ```package_versions_py.txt``` and ```package_versions_py.txt``` 

## Create a new image

First, clone the repo:

```git clone https://github.com/gabnasello/sc-env.git``` 

and run the following command to build the image (you might need sudo privileges):

```docker build --no-cache -t sc-env .```

Then you can follow the instructions in the [Docker repository](https://hub.docker.com/repository/docker/gnasello/sc-env) to use the virtual environment.

Enjoy scRNA-seq data analysis!
