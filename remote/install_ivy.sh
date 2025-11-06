# download and install apache ivy
# ivy is used to downoad jars including depencies

# create destination directory
echo $PASSWORD | sudo -S mkdir /opt/sparkplayground/ivy
echo $PASSWORD | sudo -S mkdir /opt/sparkplayground/jars
# download
wget https://dlcdn.apache.org//ant/ivy/2.5.3/apache-ivy-2.5.3-bin.tar.gz
# extract files
tar xvf apache-ivy-2.5.3-bin.tar.gz --wildcards "apache-ivy-2.5.3/ivy*.jar"
# move only the jar
echo $PASSWORD | sudo -S mv apache-ivy-2.5.3/*.jar /opt/sparkplayground/ivy
# delete downloaded file
rm apache-ivy-2.5.3-bin.tar.gz
# delete empty directory
rmdir apache-ivy-2.5.3
