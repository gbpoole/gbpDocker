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
    (Be careful ... if you change this after using a
    previous key for a while, you may need to remove
    [localhost]:2222 from your .ssh/known_hosts.)

2. Then, from the root directory, build the docker image
   (this generally only needs to be done once):
    ```
    $ ./cluster_build.sh
    ```

3.  To deploy the cluster (in this example, building 4 nodes):
    ```
    $ ./cluster_up.sh [n_nodes]
    ```

    where [n_nodes] is required and must be >=1.

3. To login to the head node:
    ```
    $ ./cluster_login.sh
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
    $ ./cluster_down.sh
    ```

