# Create a Docker Image with a conda environment for scRNA-seq data analysis

## How it works

The ```Dockerfile``` creates a Docker Image on Debian and installs miniconda. After, it creates a virtual environment called sc-env from the ```environment.ylm``` file and install some extra R packages from the ```install_r_packages.R``` file.

The full list of the Python and R packages installed is saved within the docker image in ```spec-conda-file.txt``` , ```package_versions_py.txt``` and ```package_versions_r.txt``` 

## Create a new image

First, clone the repo:

```git clone https://github.com/gabnasello/sc-env.git``` 

and run the following command to build the image (you might need sudo privileges):

```docker build --no-cache -t sc-env .```

Then you can follow the instructions in the [Docker repository](https://hub.docker.com/repository/docker/gnasello/sc-env) to use the virtual environment.

Enjoy scRNA-seq data analysis!


## Run the image from DockerHub with docker-compose

Downloading the ```docker-compose.yaml``` file is enough to pull the [Docker Image](https://hub.docker.com/repository/docker/gnasello/sc-env) and start the virtual environment.

First, you have to run the ```docker-compose``` command where the .yaml file is located (you might need sudo privileges):

```docker-compose up -d```

the detached ```-d``` mode allows you to continue using the terminal and run the service you have just created:

```docker-compose run --service-ports singlecell-environment```

When the work is finished, you exit the Docker Container by pressing ```ctrl``` + ```d```. You then need to stop and remove your containers as well as any network created.

```docker-compose down -v```

Where the -v flag removes all volumes.


