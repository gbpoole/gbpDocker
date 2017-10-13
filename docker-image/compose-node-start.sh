#!/bin/bash
export GBPDOCKER_ENV='ON'
touch /hosts/$(hostname)
/usr/sbin/sshd -D
