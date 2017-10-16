#!/bin/bash

# Set the project name that will be used in docker-compose.yml
export project_name=`basename $PWD`

# Destroy the containers
docker-compose down -v

