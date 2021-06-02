# jakarta-tck-runner
Scripts for running standalone Jakarta JPA TCK using Hibernate ORM

## Building the image

```
docker build -t jakarta-tck-runner .
```

## Bulding a specific TCK version

The image supports build arguments that allow to control which JDK base image should be used and which JPA TCK should be downloaded.
These arguments can be passed with `--build-arg TCK_VERSION=3.0.1`.

### SPEC_VERSION

The version of the Jakarta JPA specification i.e. `2.2` or `3.0`.

### TCK_VERSION

The version of the Jakarta JPA TCK i.e. `2.2.0` or `3.0.1`.

### TCK_SHA

The SHA256 of the Jakarta JPA TCK that is distributed under https://download.eclipse.org/jakartaee/persistence/3.0/jakarta-persistence-tck-${TCK_VERSION}.zip.sha256

## Environment variables

### NO_SLEEP

A usual TCK run will take very long (~8 hours). You can reduce this to ~2 hours by applying a patch that removes certain sleep statements.
This can be done by passing the `NO_SLEEP` environment variable. The image can not do this automatically because the TCK may not be re-distributed under it's license when changed.

### HIBERNATE_VERSION

The hibernate version to use for testing.


## Running the TCK

```
docker rm -f tck
docker rm -f tck-vol
docker volume create tck-vol
docker run --name tck -v tck-vol:/tck/persistence-tck/tmp/ -e NO_SLEEP=true -e HIBERNATE_VERSION=5.5.0-SNAPSHOT jakarta-tck-runner
```

If you want to test a self built version, map the locally installed hibernate jars through a volume mapping into the container:

```
docker run -v ~/.m2/repository/org/hibernate:/root/.m2/repository/org/hibernate -v tck-vol:/tck/persistence-tck/tmp/ -e NO_SLEEP=true -e HIBERNATE_VERSION=5.5.0-SNAPSHOT --name tck jakarta-tck-runner
```

## See the results

Copy the report to your local file system and the open the HTML report to see the details

```
docker cp tck:/tck/persistence-tck/tmp/JTreport/ .
```

