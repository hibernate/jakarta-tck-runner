FROM eclipse-temurin:8

ARG SPEC_VERSION=3.1
ARG TCK_VERSION=3.1.6
ARG TCK_SHA=790ca7a2a95ea098cfedafa2689c0d7a379fa62c74fed9505dd23191292f59fe
ARG TCK_URL=https://download.eclipse.org/jakartaee/persistence/${SPEC_VERSION}/jakarta-persistence-tck-${TCK_VERSION}.zip
ENV HIBERNATE_VERSION=6.0.0-SNAPSHOT
ENV TEST_PATH=$TEST_FOLDER

RUN apt-get update \
	&& apt-get install -y unzip\
    && rm -rf /var/lib/apt/lists/*

ADD ${TCK_URL} /
RUN cd /
RUN [ -z "$TCK_SHA" ] || echo "${TCK_SHA} *jakarta-persistence-tck-${TCK_VERSION}.zip" | sha256sum -c -
RUN mkdir /tck \
	&& unzip -q /jakarta-persistence-tck-${TCK_VERSION}.zip \
	&& mv /persistence-tck /tck/persistence-tck \
	&& rm /jakarta-persistence-tck-${TCK_VERSION}.zip

COPY gradle /tck/gradle
COPY gradlew /tck/
COPY LICENSE /tck/
COPY no-sleep.patch /tck/

COPY base-ts.jte /tck/
COPY build.gradle /tck/
COPY cleandb /tck/
COPY derby.ddl.persistence.sql /tck/
COPY run.sh /tck/
COPY runTests /tck/
COPY setupDerby.sh /tck/
COPY startDerby /tck/

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
 
RUN wget https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.zip \
	&& unzip -q apache-ant-1.9.16-bin.zip \
	&& mv apache-ant-1.9.16 ${ANT_HOME}

VOLUME /tck/persistence-tck/tmp/
WORKDIR /tck
ENTRYPOINT /tck/run.sh