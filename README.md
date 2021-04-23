# jakarta-tck-runner
Scripts for running standalone Jakarta JPA TCK using Hibernate ORM

## Building the image

```
docker build -t jakarta-tck-runner .
```

## Environment variables

### NO_SLEEP

A usual TCK run will take very long (~8 hours). You can reduce this to ~2 hours by applying a patch that removes certain sleep statements.
This can be done by passing the `NO_SLEEP` environment variable. The image can not do this automatically because the TCK may not be re-distributed under it's license when changed.

### HIBERNATE_VERSION

The hibernate version to use for testing.


## Running the TCK

```
docker rm -f tck
docker run --name tck -e NO_SLEEP=true -e HIBERNATE_VERSION=5.5.0-SNAPSHOT jakarta-tck-runner
```

If you want to test a self built version, map the locally installed hibernate jars through a volume mapping into the container:

```
docker run -v ~/.m2/repository/org/hibernate:/root/.m2/repository/org/hibernate -e NO_SLEEP=true -e HIBERNATE_VERSION=5.5.0-SNAPSHOT --name tck jakarta-tck-runner
```

## See the results

Copy the report to your local file system and the open the HTML report to see the details

```
docker cp tck:/tck/persistence-tck/tmp/JTreport/ .
```

