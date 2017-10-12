#!/bin/bash

yes | ssh-keygen -N "" -f ssh-keys/id_rsa.mpi
chmod 700 ssh-keys
chmod 600 ssh-keys/*
