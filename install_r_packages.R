options(unzip = "internal") # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534
options(install.packages.compile.from.source = 'always')

update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

# Install monocle3
#BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats', 'limma', 'S4Vectors', 'SingleCellExperiment', 'SummarizedExperiment', 'batchelor', 'Matrix.utils'), version = '3.13', force = TRUE)
#devtools::install_github('cole-trapnell-lab/leidenbase')
#devtools::install_github('cole-trapnell-lab/monocle3')

# Install Seurat-wrappers
#remotes::install_github('satijalab/seurat-wrappers')

# Install sceasy
#BiocManager::install('LoomExperiment'), version = '3.13')
#devtools::install_github(,'cellgeni/sceasy')

# Install MAST
BiocManager::install('MAST', version = '3.13')

# Install scran
BiocManager::install('scran', version = '3.13')

# Install DropletUtils
BiocManager::install('DropletUtils', version = '3.13')

# Install clusterExperiment
BiocManager::install('clusterExperiment', version = '3.13')
