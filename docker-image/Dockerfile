FROM ubuntu:16.04
MAINTAINER Gregory Poole <gbpoole@gmail.com>

# Set the home directory for the user
ENV USR    mpi_user
ENV HOME   /home/${USR}/
ENV DKRDIR /usr/local/gbpDocker/

# Fetch all the packages we'll want
RUN apt-get update     \
 && apt-get install -y \
     locales           \
     wget              \
     gcc               \
     g++               \
     build-essential   \
     openmpi-bin       \
     openmpi-common    \
     libopenmpi-dev    \
     ssh               \
     git               \
     vim-gnome         \
 && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

# Add and configure user
RUN useradd ${USR}   \
 && mkdir -p ${HOME} \
 && chsh -s /bin/bash ${USR}

# Clone gbpHome into the home directory
WORKDIR ${HOME}
RUN export GBPDOCKER_ENV='ON'
ADD https://api.github.com/repos/docker/docker/compare/master...HEAD /dev/null
RUN git init .
RUN git remote add -t \* -f origin https://github.com/gbpoole/gbpHome.git
RUN git checkout master
RUN echo "source ~/.bashrc.gbpHome" > .bashrc
RUN rm -r .ssh/*

# Configure ssh keys etc
WORKDIR ${HOME}
RUN mkdir -p ${HOME}/.ssh \
 && chown -R ${USR}:${USR} ${HOME}/.ssh
COPY ssh-keys/id_rsa.mpi     .ssh/id_rsa
COPY ssh-keys/id_rsa.mpi.pub .ssh/authorized_keys
COPY ssh-keys/config         .ssh/config
RUN chown -R ${USR}:${USR} ${HOME}                  \
 && chmod 700 .ssh                                  \
 && chmod 600 .ssh/*                                \
 && touch /etc/openmpi/openmpi-default-hostfile     \
 && chmod 666 /etc/openmpi/openmpi-default-hostfile \
 && mkdir /var/run/sshd

## Initialization scripts
COPY compose-head-start.sh compose-node-start.sh make-hostfile.sh ${DKRDIR}/
RUN  chmod a+x ${DKRDIR}/*.sh

# Expose port 22
EXPOSE 22

# Start the ssh daemon
WORKDIR ${HOME}
CMD ["/usr/sbin/sshd", "-D"]

