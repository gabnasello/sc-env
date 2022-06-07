# Create a Docker Image with a conda environment for scRNA-seq data analysis

## How it works

The ```Dockerfile``` creates a Docker Image from [gabnasello/datascience-env](https://hub.docker.com/repository/docker/gnasello/datascience-env). It creates virtual environments from the ```r_environment.ylm``` (sc-R), ```py_environment.ylm``` (sc-py), ```cell-comm_environment.ylm``` (cell-comm) and the ```grn-inf_environment.ylm``` (grn-inf) files. Moreover, the ```Dockerfile``` installs some extra R packages from the ```sc-R_install_r_packages.R``` file.

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


