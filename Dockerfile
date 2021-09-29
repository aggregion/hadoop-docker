FROM ubuntu:20.04
ARG HADOOP_VERSION=3.3.0


# Install tzdata, Python, Java
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata \
    python python3 python3-pip openjdk-8-jdk bc iputils-ping ssh pdsh

# Set environment variables
ENV JAVA_HOME      /usr/lib/jvm/java-8-openjdk-amd64
ENV ATLAS_DIST    /home/atlas/dist
ENV ATLAS_HOME    /opt/atlas
ENV ATLAS_SCRIPTS /home/atlas/scripts
ENV PATH          /usr/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# setup groups, users, directories
RUN groupadd hadoop && \
    useradd -g hadoop -ms /bin/bash hdfs && \
    useradd -g hadoop -ms /bin/bash yarn && \
    useradd -g hadoop -ms /bin/bash hive && \
    useradd -g hadoop -ms /bin/bash hbase && \
    useradd -g hadoop -ms /bin/bash kafka



ADD https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}.tar.gz /tmp

RUN tar xvfz /tmp/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz --directory=/opt/ && \
    ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm -f /tmp/hadoop-${HADOOP_VERSION}.tar.gz

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV HADOOP_HOME        /opt/hadoop
ENV HADOOP_CONF_DIR    /opt/hadoop/etc/hadoop
ENV HADOOP_HDFS_HOME   /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV YARN_HOME          /opt/hadoop
ENV PATH               /usr/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/hadoop/bin

EXPOSE 9000
EXPOSE 8088

ENTRYPOINT [ "/entrypoing.sh" ]
