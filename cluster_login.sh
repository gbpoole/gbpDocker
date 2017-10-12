#!/bin/bash
# Use -q option to disable warnings, so that status isn't confused
printf "Checking connection..."
status=$(ssh -q -p 2222 -i docker-image/ssh-keys/id_rsa.mpi -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=1 mpi_user@localhost echo ok 2>&1)
if [[ $status == ok ]] ; then
    printf "succeeded.\n" 
	ssh -q -p 2222 -i docker-image/ssh-keys/id_rsa.mpi -o StrictHostKeyChecking=no mpi_user@localhost
else
    printf "failed! %s\n" "$status"
    printf "\n"
	printf "Make sure that the cluster has been started with './cluster_up.sh'.\n"
	exit 2
fi

