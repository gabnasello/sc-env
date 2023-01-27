FROM jupyter/r-notebook:2022-11-07

# Configure environment
ENV DOCKER_IMAGE_NAME='sc-env'
ENV VERSION='2023-01-28' 

# Docker name to shell prompt
ENV PS1A="[docker] \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
RUN echo 'PS1=$PS1A' >> ~/.bashrc
RUN echo 'conda activate base' >> ~/.bashrc

# How to connect all conda envs to jupyter notebook
# https://stackoverflow.com/questions/61494376/how-to-connect-r-conda-env-to-jupyter-notebook
RUN conda install -y -n base nb_conda_kernels

# Create sc-R environment and install R packages
ADD sc-R/r_environment.yml .
RUN conda env create -f r_environment.yml

ADD sc-R/sc-R_install_r_packages.R .

# Activating a Conda environment in your Dockerfile
# [https://pythonspeed.com/articles/activate-conda-dockerfile/]

SHELL ["conda", "run", "-n", "sc-R", "/bin/bash", "-c"]
RUN /opt/conda/envs/sc-R/bin/Rscript sc-R_install_r_packages.R

# default SHELL command
SHELL ["/bin/sh", "-c"] 
# Create sc-py environment
ADD sc-py/py_environment.yml .
RUN conda env create -f py_environment.yml

# Create cell-comm environment
ADD cell-comm/cell-comm_environment.yml .
RUN conda env create -f cell-comm_environment.yml

# Create grn-inf environment and install R packages
# Instructions from [http://velocyto.org/velocyto.py/install/index.html]
# and [https://morris-lab.github.io/CellOracle.documentation/installation/index.html#install-celloracle]
RUN conda create -n grn-inf python=3.8

# Activating a Conda environment in your Dockerfile
# [https://pythonspeed.com/articles/activate-conda-dockerfile/]
SHELL ["conda", "run", "-n", "grn-inf", "/bin/bash", "-c"]

RUN pip install pysam \
 && conda install numpy scipy cython numba matplotlib scikit-learn h5py click \
 && conda install -c bioconda pybedtools \
 && pip install velocyto \
 && pip install celloracle

ADD grn-inf/grn-inf_install_r_packages.R .
RUN conda install r-essentials
RUN /opt/conda/envs/grn-inf/bin/Rscript grn-inf_install_r_packages.R

RUN echo "conda env list" >> ~/.bashrc

# Set the jl command to create a JupytetLab shortcut
ADD scripts/launch_jupyterlab.sh /
RUN echo "alias jl='bash /launch_jupyterlab.sh'" >> ~/.bashrc

ADD scripts/entrypoint.sh /
ADD scripts/message.sh /
RUN echo "bash /message.sh" >> ~/.bashrc