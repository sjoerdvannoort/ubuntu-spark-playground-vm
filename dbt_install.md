## virtual environment
install module and create environment

sudo apt install python3-venv

sudo mkdir /opt/env-dbt
sudo python3 -m venv /opt/env-dbt

activate
sudo chmod -R 777 /opt/env-dbt
source /opt/env-dbt/bin/activate
pip3 install dbt-core
pip3 install dbt-spark

export SPARK_HOME=/opt/spark
export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/pyspark.zip:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH"
export PATH="$SPARK_HOME/bin:$PATH"

dbt profile.yml

spark_first:
  target: dev
  outputs:
    dev:
      method: session
      host: NA
      schema: dwh
      threads: 1
      type: spark
      #spark_conf:
      server_side_parameters:
        spark.sql.warehouse.dir: /shared/manageddata
        spark.executor.extraClassPath: /opt/sparkplayground/jars/io.delta-delta-spark_2.13-4.0.0.jar:/opt/sparkplayground/jars/io.delta-delta-storage-4.0.0.jar
        spark.sql.extensions: io.delta.sql.DeltaSparkSessionExtension
        spark.sql.catalog.spark_catalog: org.apache.spark.sql.delta.catalog.DeltaCatalog
        javax.jdo.option.ConnectionDriverName: org.apache.derby.jdbc.ClientDriver
        javax.jdo.option.ConnectionURL: jdbc:derby://localhost:1527//opt/sparkplayground/metastore/hive_derby