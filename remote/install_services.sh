# symlink the service files
echo $PASSWORD | sudo -S ln -s /opt/derby/systemd/derbyns.service /etc/systemd/system/derbyns.service
echo $PASSWORD | sudo -S ln -s /opt/sparkplayground/systemd/jupyternb.service /etc/systemd/system/jupyternb.service
echo $PASSWORD | sudo -S ln -s /opt/sparkplayground/systemd/sparkthrift.service /etc/systemd/system/sparkthrift.service

# reload the configuration files
echo $PASSWORD | sudo -S systemctl daemon-reload

#enable the services
echo $PASSWORD | sudo -S systemctl enable derbyns.service
echo $PASSWORD | sudo -S systemctl enable jupyternb.service
echo $PASSWORD | sudo -S systemctl enable sparkthrift.service

#start the services
echo $PASSWORD | sudo -S systemctl start derbyns.service
echo $PASSWORD | sudo -S systemctl start jupyternb.service
echo $PASSWORD | sudo -S systemctl start sparkthrift.service