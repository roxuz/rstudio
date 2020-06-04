# Use an existing docker image as a base
FROM rocker/verse

# Download and install a dependency
RUN /usr/local/bin/Rscript -e 'install.packages("tidytext")'
RUN /usr/local/bin/Rscript -e 'install.packages("textstem")'
RUN /usr/local/bin/Rscript -e 'install.packages("gridExtra")'
RUN /usr/local/bin/Rscript -e 'install.packages("sparklyr")'

