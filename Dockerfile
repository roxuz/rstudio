# Use an existing docker image as a base
FROM rocker/verse:3.6.3

# Download and install a dependency

RUN install2.r tidytext textstem gridExtra sparklyr

RUN apt-get update && apt-get install gnupg -y
RUN wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
RUN echo deb http://eu.ceph.com/debian-dumpling/ $(lsb_release -sc) main | tee /etc/apt/sources.list.d/ceph.list
RUN apt-get install ceph -y

#RUN /usr/local/bin/Rscript -e 'install.packages("tidytext")'
#RUN /usr/local/bin/Rscript -e 'install.packages("textstem")'
#RUN /usr/local/bin/Rscript -e 'install.packages("gridExtra")'
#RUN /usr/local/bin/Rscript -e 'install.packages("sparklyr")'

ARG ssh_pub_key1
ARG ssh_pub_key2

# Authorize SSH Host
RUN mkdir -p /home/rstudio/.ssh && \
    chmod 0700 /home/rstudio/.ssh && \
    chown rstudio:rstudio /home/rstudio/.ssh

# Add the keys and set permissions
RUN echo "$ssh_pub_key1" >> /home/rstudio/.ssh/authorized_keys && \
    echo "$ssh_pub_key2" >> /home/rstudio/.ssh/authorized_keys && \
    chmod 600 /home/rstudio/.ssh/authorized_keys && \
    chown rstudio:rstudio /home/rstudio/.ssh/authorized_keys

RUN mkdir -p /etc/services.d/sshd && \
    echo '#!/usr/bin/execlineb -P' > /etc/services.d/sshd/run && \
    echo '/usr/sbin/sshd -D' >> /etc/services.d/sshd/run && \
    ssh-keygen -A && \
    mkdir -p /run/sshd

COPY ojdbc6.jar /home/rstudio/
RUN install2.r RJDBC && \
    chown rstudio:rstudio /home/rstudio/ojdbc6.jar

# RUN mkdir -p /etc/services.d/ssh && \
#     echo '#!/usr/bin/with-contenv bash' > /etc/services.d/ssh/run && \
#     echo '/etc/init.d/ssh start' >> /etc/services.d/ssh/run


# CMD /etc/init.d/ssh start

# ENTRYPOINT /etc/init.d/ssh start && bash

# RUN echo '/etc/init.d/ssh start' >> /etc/services.d/rstudio/run



