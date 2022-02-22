FROM gnasello/datascience-env:latest

USER root

# Create sc-R environment and install R packages
ADD r_environment.yml .
RUN conda env create -f r_environment.yml

ADD sc-R_install_r_packages.R .
RUN /opt/conda/envs/sc-R/bin/Rscript sc-R_install_r_packages.R

# Create sc-py environment
ADD py_environment.yml .
RUN conda env create -f py_environment.yml

# Create cell-comm environment
ADD cell-comm_environment.yml .
RUN conda env create -f cell-comm_environment.yml

# Create grn-inf environment and install R packages
ADD grn-inf_environment.yml .
RUN conda env create -f grn-inf_environment.yml

ADD grn-inf_install_r_packages.R .
RUN /opt/conda/envs/grn-inf/bin/Rscript grn-inf_install_r_packages.R

RUN echo "conda env list" >> ~/.bashrc
