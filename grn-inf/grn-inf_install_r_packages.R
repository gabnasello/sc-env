options(unzip = "internal") # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534

#####------ FROM notebooks and Dockerfile of theis tutorial for sc-data analysis -------######

options(install.packages.compile.from.source = 'always')

update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

######------------######

# Install R packages needed for CellOracle network analysis.
# [https://morris-lab.github.io/CellOracle.documentation/installation/index.html#r-requirements]
install.packages("igraph", repos = 'http://cran.us.r-project.org')
install.packages("linkcomm", repos = 'http://cran.us.r-project.org')
install.packages("https://cran.r-project.org/src/contrib/Archive/rnetcarto/rnetcarto_0.2.4.tar.gz",
                 repos = NULL, type = "source", configure.args = '--host=host')