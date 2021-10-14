# install miniconda from https://github.com/ContinuumIO/docker-images/tree/master/miniconda3/debian/Dockerfile
# install R packages from https://github.com/theislab/single-cell-tutorial/blob/master/Dockerfile
# install environmet.yml from Gabriele Nasello
# Activate conda environment in Dockerfile https://pythonspeed.com/articles/activate-conda-dockerfile/


FROM debian:bullseye-slim

LABEL maintainer="Anaconda, Inc"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# hadolint ignore=DL3008
RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        mercurial \
        openssh-client \
        procps \
        subversion \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install system libraries required for python and R installations
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \ 
	build-essential \
	apt-utils \
	ca-certificates \
	zlib1g-dev \
	gfortran \
	locales \
	libxml2-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	libzmq3-dev \
	libreadline6-dev \
	xorg-dev \
	libcairo-dev \
	libpango1.0-dev \
	libbz2-dev \
	liblzma-dev \
	libffi-dev \
	libsqlite3-dev \
	nodejs \
	npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install common linux tools
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
	wget \
	curl \
	htop \
	less \
	nano \
	vim \
	emacs \
	git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

# Leave these args here to better use the Docker build cache
ARG CONDA_VERSION=py38_4.9.2

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"; \
        SHA256SUM="1314b90489f154602fd794accfc90446111514a5a72fe1f71ab83e07de9504a7"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-s390x.sh"; \
        SHA256SUM="4e6ace66b732170689fd2a7d86559f674f2de0a0a0fbaefd86ef597d52b89d16"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-aarch64.sh"; \
        SHA256SUM="b6fbba97d7cef35ebee8739536752cd8b8b414f88e237146b11ebf081c44618f"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-ppc64le.sh"; \
        SHA256SUM="2b111dab4b72a34c969188aa7a91eca927a034b14a87f725fa8d295955364e71"; \
    fi && \
    wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    #if [ "${CONDA_VERSION}" != "latest" ]; then sha256sum --check --status shasum; fi && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

ADD environment.yml .

RUN conda env create -f environment.yml

# Initialize conda in bash config fiiles:
RUN conda init bash  && \
    echo "conda activate sc-env" >> ~/.bashrc && \
    echo "alias jl='jupyter lab --allow-root --port=8888 --ip=0.0.0.0'" >> ~/.bashrc

ENV PATH="opt/conda/envs/sc-env/lib/R/bin:${PATH}"
ENV LD_LIBRARY_PATH="opt/conda/envs/sc-env/lib/R/lib:${LD_LIBRARY_PATH}"

ADD install_r_packages.R .

RUN Rscript install_r_packages.R && \
    Rscript -e 'writeLines(capture.output(sessionInfo()), "../package_versions_r.txt")' --default-packages=scran,RColorBrewer,monocle3,SingleCellExperiment,ggplot2,MAST,DropletUtils,Seurat,seurat-wrappers,sceasy
  
RUN pip freeze > ../package_versions_py.txt
  
RUN conda list --explicit > ../spec-conda-file.txt
