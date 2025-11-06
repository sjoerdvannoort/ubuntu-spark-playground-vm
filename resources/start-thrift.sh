#!/usr/bin/env bash


## Start spark daemons.
# Starts the master on this node.
# Also starts a worker on this node

# create  environment variables if not already there.
if [ -z "${SPARK_HOME}" ]; then
  export SPARK_HOME=/opt/spark
fi

# Load the Spark configuration
. "${SPARK_HOME}/sbin/spark-config.sh"

# Start Master
#"${SPARK_HOME}/sbin"/start-master.sh -h sparkplayground.mshome.net

# Start Workers
#"${SPARK_HOME}/sbin"/start-worker.sh  spark://sparkplayground.mshome.net:7077 

# Start thrift server (JDBC)
/opt/spark/sbin/start-thriftserver.sh --master local[4]\
 --conf spark.sql.warehouse.dir=/shared/manageddata\
 --hiveconf hive.server2.transport.mode=http\
 --hiveconf hive.server2.thrift.http.port=10001\
 --hiveconf hive.server2.authentication=NOSASL\
 --hiveconf hive.server2.thrift.port=10002\
 --hiveconf javax.jdo.option.ConnectionDriverName=org.apache.derby.jdbc.ClientDriver\
 --hiveconf javax.jdo.option.ConnectionURL=jdbc:derby://localhost:1527//opt/sparkplayground/metastore/hive_derby
