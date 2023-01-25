FROM gnasello/datascience-env:2023-01-19

# Configure environment
ENV DOCKER_IMAGE_NAME='sc-env'
ENV VERSION='2023-01-23' 

USER root

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
 && pip install velocyto \
 && pip install celloracle

ADD grn-inf/grn-inf_install_r_packages.R .
RUN conda install r-essentials
RUN /opt/conda/envs/grn-inf/bin/Rscript grn-inf_install_r_packages.R

RUN echo "conda env list" >> ~/.bashrc

USER jovyan