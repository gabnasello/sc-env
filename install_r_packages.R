options(unzip = "internal") # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534

#####------ FROM notebooks and Dockerfile of theis tutorial for sc-data analysis -------######

options(install.packages.compile.from.source = 'always')

update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

######------------######

# Install Seurat-wrappers
system('wget https://github.com/satijalab/seurat-wrappers/archive/refs/heads/master.zip')
system('unzip master.zip')
system('mv seurat-wrappers-master/ seurat-wrappers/')
system('R CMD build seurat-wrappers')
install.packages(list.files(pattern="[SeuratWrappers]*.tar.gz"), repos = NULL)
system('rm -rf master.zip seurat-wrappers/ SeuratWrappers*.tar.gz')

# Install sceasy
#BiocManager::install('LoomExperiment', version = '3.13')
#devtools::install_github(,'cellgeni/sceasy')

# Install MAST
BiocManager::install('MAST', version = '3.13')

# Install scran
BiocManager::install('scran', version = '3.13')

# Install DropletUtils
BiocManager::install('DropletUtils', version = '3.13')

# Install clusterExperiment
BiocManager::install('clusterExperiment', version = '3.13')