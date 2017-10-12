gbpDocker
---

This project provides a base image for building projects
that require an MPI-enabled cluster.  It began  with a
clone of:

 git@github.com:DaisukeMiyamoto/docker-openmpi.git
 (commit b8ad167216bba7fef9a7802bcfc7ceda763aea9b)

and has evolved from there.

To use:

1. First, you may want to generate a personalized
   ssh public key pair:
    ```
    $ cd docker-image
    $ ./change_ssh_keys.sh
    ```

2. Then, build the docker image:
    ```
    $ docker-compose build
    ```

3.  To deploy the cluster (in this example, building 4 nodes):
    ```
    $ docker-compose up --scale node=4 -d
    ```

3. To login to the head node:
    ```
    $ ./connect.sh
    ```

4. To run mpi programs from the head node:
    ```
    $ ./make-hostfile.sh
    $ mpirun -np 16 hostname
    252f9f5abc18
    252f9f5abc18
    252f9f5abc18
    252f9f5abc18
    fa00f144c7be
    0ebd38ff982e
    fa00f144c7be
    0ebd38ff982e
    fa00f144c7be
    0ebd38ff982e
    fa00f144c7be
    0ebd38ff982e
    4c1364ddf9d9
    4c1364ddf9d9
    4c1364ddf9d9
    4c1364ddf9d9
    ```

4. Finally, to shutdown the cluster:
    ```
    $ docker-compose down -v
    ```

