#!/bin/bash

podman build -f Dockerfile.jdk11 -t jakarta-tck-runner --build-arg TCK_VERSION=3.0.1 --build-arg TCK_SHA=0e77804ead3990a53cdc325d2b0ddc1b15a3993d7866e5aa3717cc55d95f8bbc

podman rm -f tck

podman volume rm -f tck-vol

podman volume create tck-vol

if [ "$1" != "" ]; then
        podman run -v ~/.m2/repository/org/hibernate:/root/.m2/repository/org/hibernate:z -v tck-vol:/tck/persistence-tck/tmp/:z -e NO_SLEEP=true -e HIBERNATE_VERSION=6.0.0-SNAPSHOT -e TEST_PATH=$1 --name tck jakarta-tck-runner
    else
        podman run -v ~/.m2/repository/org/hibernate:/root/.m2/repository/org/hibernate:z -v tck-vol:/tck/persistence-tck/tmp/:z -e NO_SLEEP=true -e HIBERNATE_VERSION=6.0.0-SNAPSHOT --name tck jakarta-tck-runner
fi

