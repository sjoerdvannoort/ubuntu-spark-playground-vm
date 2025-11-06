# download spark
wget https://dlcdn.apache.org/spark/spark-4.0.1/spark-4.0.1-bin-hadoop3.tgz

# extract here
tar xvf spark-4.0.1-bin-hadoop3.tgz

# remove if needed
echo $PASSWORD | sudo -S rm -f -R /opt/spark

# move extracted
echo $PASSWORD | sudo -S mv spark-4.0.1-bin-hadoop3/ /opt/spark

# delete downloaded file
rm spark-4.0.1-bin-hadoop3.tgz