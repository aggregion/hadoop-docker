#!/bin/bash

service ssh start
su -c "${HADOOP_HOME}/sbin/start-dfs.sh" hdfs
su -c "${HADOOP_HOME}/sbin/start-yarn.sh" yarn

