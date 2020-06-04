# Use an existing docker image as a base
FROM rocker/verse

# Download and install a dependency

RUN service ssh start

RUN apt-get update && apt-get install gnupg
RUN wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
RUN echo deb http://eu.ceph.com/debian-dumpling/ $(lsb_release -sc) main | tee /etc/apt/sources.list.d/ceph.list
RUN apt-get install ceph

#RUN /usr/local/bin/Rscript -e 'install.packages("tidytext")'
#RUN /usr/local/bin/Rscript -e 'install.packages("textstem")'
#RUN /usr/local/bin/Rscript -e 'install.packages("gridExtra")'
#RUN /usr/local/bin/Rscript -e 'install.packages("sparklyr")'

