#!/bin/bash

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

docker-compose up --scale node=$N_NODES -d 
