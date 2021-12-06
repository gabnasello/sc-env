options(unzip = "internal") # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534

#####------ FROM notebooks and Dockerfile of theis tutorial for sc-data analysis -------######

options(install.packages.compile.from.source = 'always')

update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

######------------######

# Install Seurat-wrappers and avoid any issue related to GitHub API tokens
system('wget https://github.com/satijalab/seurat-wrappers/archive/refs/heads/master.zip')
system('unzip master.zip')
system('mv seurat-wrappers-master/ seurat-wrappers/')
system('R CMD build seurat-wrappers')
install.packages(list.files(pattern="[SeuratWrappers]*.tar.gz"), repos = NULL)
system('rm -rf master.zip seurat-wrappers/ SeuratWrappers*.tar.gz')

# Install MAST
BiocManager::install('MAST')

# Install scran
BiocManager::install('scran')

# Install DropletUtils
BiocManager::install('DropletUtils')

# Install clusterExperiment
BiocManager::install('clusterExperiment')

# Install sceasy and avoid any issue related to GitHub API tokens
BiocManager::install('LoomExperiment') # requirement for sceasy
system('wget https://github.com/cellgeni/sceasy/archive/refs/heads/master.zip')
system('unzip master.zip')
system('mv sceasy-master/ sceasy//')
system('R CMD build sceasy')
install.packages(list.files(pattern="[sceasy]*.tar.gz"), repos = NULL)
system('rm -rf master.zip sceasy/ sceasy*.tar.gz')


# Install Seurat-data and avoid any issue related to GitHub API tokens
# devtools::install_github('satijalab/seurat-data')
system('wget https://github.com/satijalab/seurat-data/archive/refs/heads/master.zip')
system('unzip master.zip')
system('mv seurat-data-master/ seurat-data//')
system('R CMD build seurat-data')
install.packages(list.files(pattern="[Seurat]*.tar.gz"), repos = NULL)
system('rm -rf master.zip seurat-data/ Seurat*.tar.gz')