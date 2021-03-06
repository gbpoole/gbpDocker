#!/bin/bash

run() {
  "$@"
  if [ $? -ne 0 ]; then
    echo "$1 failed with exit code $?"
    return 1
  else
    return 0
  fi
}

# Validate and parse paramaters
if [ $# -ne 1 ]; then
    echo "Syntax: "$0" [n_nodes>=1]"
    exit 1
else
    export N_NODES=$1
fi

# Make sure that N_NODES>=1 and is an integer
if [ $N_NODES -lt 1 ] || ! [[ $N_NODES =~ ^-?[0-9]+$ ]] ; then
    echo "Error: n_nodes {"$N_NODES"} is not a valid positive integer greater than 1."
    exit 2
fi

# Set the project name that will be used in docker-compose.yml
export project_name=`basename $PWD`

# Create the containers
run docker-compose up --scale node=$N_NODES -d 

# Get the head container ID
head_id=$(docker-compose ps -q head)

# Create the hostname file
run docker exec $head_id /usr/local/gbpDocker/make-hostfile.sh

