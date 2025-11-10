# create destination directories
echo $PASSWORD | sudo -S mkdir -p /opt/derby/bin
echo $PASSWORD | sudo -S mkdir -p /opt/derby/lib
echo $PASSWORD | sudo -S mkdir -p /opt/derby/systemd

# download and install derby (network server)
wget https://dlcdn.apache.org/db/derby/db-derby-10.16.1.1/db-derby-10.16.1.1-bin.tar.gz

# extract files
tar xvf db-derby-10.16.1.1-bin.tar.gz --wildcards "db-derby-10.16.1.1-bin/bin/*"
tar xvf db-derby-10.16.1.1-bin.tar.gz --wildcards "db-derby-10.16.1.1-bin/lib/*"

# remove bat file, it's not windows
rm db-derby-10.16.1.1-bin/bin/*.bat

# move files, remove first as overwrite is tricky
echo $PASSWORD | sudo -S rm /opt/derby/bin/*
echo $PASSWORD | sudo -S rm /opt/derby/lib/*
echo $PASSWORD | sudo -S mv -f db-derby-10.16.1.1-bin/bin /opt/derby
echo $PASSWORD | sudo -S mv -f db-derby-10.16.1.1-bin/lib /opt/derby
echo $PASSWORD | sudo -S mv -f derbyns.service /opt/derby/systemd

# remove empty folder
rmdir db-derby-10.16.1.1-bin
# delete downloaded file
rm db-derby-10.16.1.1-bin.tar.gz