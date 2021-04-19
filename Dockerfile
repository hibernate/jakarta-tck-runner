FROM openjdk:8-jdk

COPY persistence-tck /tck/persistence-tck
COPY gradle /tck/gradle
COPY gradlew /tck/
COPY README.md /tck/
COPY LICENSE /tck/

COPY base-ts.jte /tck/
COPY build.gradle /tck/
COPY cleandb /tck/
COPY derby.ddl.persistence.sql /tck/
COPY run.sh /tck/
COPY runOrmTests /tck/
COPY runSigTests /tck/
COPY setDerbyEnv /tck/
COPY setenv /tck/
COPY setupDerby.sh /tck/
COPY startDerby /tck/
COPY stopDerby /tck/

ENV TCK_HOME=/tck
ENV DERBY_HOME=$TCK_HOME/derby
ENV TS_HOME=$TCK_HOME/persistence-tck
ENV ANT_HOME=$TCK_HOME/ant
ENV PATH=$TS_HOME/bin:$ANT_HOME/bin:$PATH

ENV DERBY_INSTALL_DIR=${DERBY_HOME}/derby-db
ENV DERBY_DATA_DIR=${DERBY_HOME}/data
ENV DERBY_LOG_DIR=${DERBY_HOME}/logs

RUN wget https://archive.apache.org/dist/db/derby/db-derby-10.13.1.1/db-derby-10.13.1.1-bin.zip \
	&& unzip -q db-derby-10.13.1.1-bin.zip \
	&& mkdir -p ${DERBY_HOME} \
	&& mv db-derby-10.13.1.1-bin ${DERBY_INSTALL_DIR}
 
RUN wget http://www.trieuvan.com/apache//ant/binaries/apache-ant-1.9.15-bin.zip \
	&& unzip -q apache-ant-1.9.15-bin.zip \
	&& mv apache-ant-1.9.15 ${ANT_HOME}

VOLUME /tck/persistence-tck/tmp/