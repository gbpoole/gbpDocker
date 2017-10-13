#!/bin/bash

# Use current directory name for project name
echo project_name=`basename $PWD`  > .env

docker-compose build 
