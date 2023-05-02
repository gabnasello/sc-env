# Docker Image for scRNA-seq data analysis with Python and R

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/gabnasello/sc-env/HEAD)

# Build the Docker Image

From the project folder, run the command below:

```bash build.sh```

# Run Docker container

## docker-compose approach (recommended)

From the project folder, run the command below:

```docker-compose up -d```

To connect to a container that is already running ("datascience" is the service name):

```docker-compose exec sc-env /bin/bash```

Close the container with:

```docker-compose down```

## Alternative approach

You can run the following command:

```docker run -d -it --rm  -p 7777:7777 -p 7878:7878 --volume $HOME:/home/researcher --user root --name sc-env gnasello/sc-env:latest```

To connect to a container that is already running ("sc-env" is the container name):

```docker exec -it sc-env /bin/bash```

After use, you close the container with:

```docker rm -f sc-env```