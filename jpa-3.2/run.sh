#!/bin/bash

cd ${TCK_HOME}/persistence-tck/artifacts; ./artifact-install.sh; cd -;

JAVA_VER=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F '.' '{sub("^$", "0", $2); print $1}')
if [ "$JAVA_VER" == '17' ]; then
	GF_VERSION=8.0.0-JDK17-M5
else
	GF_VERSION=8.0.0-M5
fi

set -x
if [ "$RDBMS" == 'mysql' ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,mysql" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.password=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:mysql://${DB_HOST:-localhost}/hibernate_orm_test?allowPublicKeyRetrieval=true"
elif [ "$RDBMS" == 'postgresql' ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,postgresql" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.password=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:postgresql://${DB_HOST:-localhost}/hibernate_orm_test?preparedStatementCacheQueries=0&escapeSyntaxCallMode=callIfNoReturn" \
    "-Dpostgresql.jdbc.version=42.7.4"
elif [ "$RDBMS" == 'db2' ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,db2" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=orm_test" \
    "-Djakarta.persistence.jdbc.password=orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:db2://${DB_HOST:-localhost}:50000/orm_test"
elif [ "$RDBMS" == 'oracle' ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,oracle" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.password=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:oracle:thin:@${DB_HOST:-localhost}:1521/freepdb1"
elif [ "$RDBMS" == 'mssql' ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,mssqlserver" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=sa" \
    "-Djakarta.persistence.jdbc.password=Hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:sqlserver://${DB_HOST:-localhost};databaseName=hibernate_orm_test;sendTimeAsDatetime=false;trustServerCertificate=true"
elif [ "$RDBMS" == 'sybase' ]; then
  mvn org.apache.maven.plugins:maven-install-plugin:3.1.1:install-file -Dfile=${TCK_HOME}/jconn42.jar -DgroupId=com.sybase -DartifactId=jdbc42 -Dversion=1.0.0 -Dpackaging=jar
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,sybase" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.password=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:sybase:Tds:${DB_HOST:-localhost}:9000/hibernate_orm_test" \
	"-Djakarta.persistence.jdbc.driver=com.sybase.jdbc4.jdbc.SybDriver" \
	"-Djpa.provider.implementation.specific.additional.properties=:connection.init_sql=set ansinull on set quoted_identifier on"
elif [ "$RDBMS" == 'derby' ] || [ -z "$RDBMS" ]; then
  mvn -e -f ${TCK_HOME}/persistence-tck/bin/pom.xml -P "hibernate,derby" verify "-Dhibernate.version=${HIBERNATE_VERSION}" \
    "-Dglassfish.container.version=${GF_VERSION}" \
    "-Djakarta.persistence.jdbc.user=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.password=hibernate_orm_test" \
    "-Djakarta.persistence.jdbc.url=jdbc:derby://${DB_HOST:-localhost}:1527/derbyDB;create=true"
else
  echo "Unsupported RDBMS: ${RDBMS}"
  exit 1
fi
