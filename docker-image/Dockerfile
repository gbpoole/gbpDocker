FROM ubuntu:16.04
MAINTAINER Gregory Poole <gbpoole@gmail.com>

# Take the location of the gbpDocker files as an argument
ARG gbpDocker_dir

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
ADD https://api.github.com/repos/docker/docker/compare/master...HEAD /dev/null
RUN git init .
RUN git remote add -t \* -f origin https://github.com/gbpoole/gbpHome.git
RUN git checkout master
RUN echo "source ~/.bashrc.gbpHome" > .bashrc
RUN rm -rf .ssh/* 3rd_Party

# Configure ssh keys etc
WORKDIR ${HOME}
RUN mkdir -p ${HOME}/.ssh \
 && chown -R ${USR}:${USR} ${HOME}/.ssh
COPY ${gbpDocker_dir}/ssh-keys/id_rsa.mpi     .ssh/id_rsa
COPY ${gbpDocker_dir}/ssh-keys/id_rsa.mpi.pub .ssh/authorized_keys
COPY ${gbpDocker_dir}/ssh-keys/config         .ssh/config
RUN chown -R ${USR}:${USR} ${HOME}                  \
 && chmod 700 .ssh                                  \
 && chmod 600 .ssh/*                                \
 && touch /etc/openmpi/openmpi-default-hostfile     \
 && chmod 666 /etc/openmpi/openmpi-default-hostfile \
 && mkdir /var/run/sshd

## Initialization scripts
COPY ${gbpDocker_dir}/compose-head-start.sh ${gbpDocker_dir}/compose-node-start.sh ${DKRDIR}/
COPY ${gbpDocker_dir}/make-hostfile.sh ${HOME}/
RUN  echo "GBPDOCKER_ENV=ON" > .env.gbpDocker
RUN  chmod a+x ${DKRDIR}/*.sh \
  && chmod a+x ${HOME}/*.sh

# Expose port 22
EXPOSE 22

# Start the ssh daemon
WORKDIR ${HOME}
CMD ["/usr/sbin/sshd", "-D"]

