# mkdir -p creates parent directories if needed, and ignores if the directory already exists
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/sbin
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/systemd
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/metastore
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/jars
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/notebooks/examples

# read/write/execute permissions for all users
echo $PASSWORD | sudo -S chmod -R 777 /opt/sparkplayground

echo $PASSWORD | sudo -S mkdir -p /shared/manageddata
echo $PASSWORD | sudo -S mkdir -p /shared/sourcedata/commercial_property
echo $PASSWORD | sudo -S chmod -R 777 /shared