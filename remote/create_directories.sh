# mkdir -p creates parent directories if needed, and ignores if the directory already exists
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/sbin
echo $PASSWORD | sudo -S mkdir -p /opt/sparkplayground/systemd
# read/write/execute permissions for all users
echo $PASSWORD | sudo -S chmod -R 777 /opt/sparkplayground