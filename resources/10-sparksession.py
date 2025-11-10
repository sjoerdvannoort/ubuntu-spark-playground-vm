import os

global sparkplay_info
if os.environ.get("IPYTHON_START_SPARK", "N") == "Y":
	jcp = os.environ.get("CLASSPATH", "*EMPTY*")
	sparkplay_info = "IPYTHON_START_SPARK set to Y, creating spark session"
	from pyspark.sql import SparkSession

	spark = SparkSession \
		.builder \
		.appName("Jupyternb") \
		.config("spark.driver.extraClassPath","/opt/sparkplayground/jars/io.delta-delta-spark_2.13-4.0.0.jar:/opt/sparkplayground/jars/io.delta-delta-storage-4.0.0.jar:/opt/derby/lib/*")\
		.config("spark.executor.extraClassPath","/opt/sparkplayground/jars/io.delta-delta-spark_2.13-4.0.0.jar:/opt/sparkplayground/jars/io.delta-delta-storage-4.0.0.jar")\
		.config("spark.sql.warehouse.dir", "/shared/manageddata")\
		.config("spark.hadoop.javax.jdo.option.ConnectionURL", "jdbc:derby://localhost:1527//opt/sparkplayground/metastore/hive_derby;create=true")\
		.config("spark.hadoop.javax.jdo.option.ConnectionDriverName", "org.apache.derby.jdbc.ClientDriver")\
		.config("spark.sql.hive.metastore.schema.verification", "false")\
		.config("spark.sql.hive.metastore.schema.verification.record.version", "false")\
		.config("spark.sql.scripting.enabled", True)\
		.config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")\
		.config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")\
		.config("spark.sql.sources.default", "delta")\
		.enableHiveSupport()\
		.master("local[4]")\
		.getOrCreate()

	# needs "spark" sparkSession
	get_ipython().run_line_magic('load_ext', 'sparksql_magic')

	# get rid of pesky hive metastore version warnings
	spark.sparkContext.setLogLevel("ERROR")
else:
	sparkplay_info = "IPYTHON_START_SPARK not set to Y, not creating spark session"
