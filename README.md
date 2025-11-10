# ubuntu-spark-playground-vm
script and instructions to create an ubuntu hyper-V image with a spark/jupyter stack

## Get and install ubuntu
To get a minimal installation, download Ubuntu Server iso from the ubuntu website. This document assumes Ubuntu 24.04.3 LTS.  
Open the Hyper-V Manager and select Quick Create, then local installation source and the ubuntu iso file.   
Now start the new machine, it will start the Ubuntu setup.
Select defaults, but for installation type choose Ubuntu server (minimized).  
At guided storage configuration select entire disk, deselect LVM group. In the next screen, storage configuration, decrease the size of the last partition, so that it can be used for a shared partition to be added later.  
In the profile section, this document assumes "sparkadmin" as user name and "sparkplayground" as machine name.  
Select install open ssh.

## Using SSH
While you can connect to your ubuntu VM and use the console, using ssh on your windows host will allow easy copy and paste. To start start, open CMD shell and type:
```
ssh sparkadmin@sparkplayground@mshome.net
```

## manual steps after install
Install an editor
```
sudo apt install nano
```

Adding the ntfs partition
check the existing partitions
```
sudo fdisk -l
```
Typically, there is a disk /dev/sda with these devices:  
/dev/sda1   EFI System  
/dev/sda2   Linux filesystem  

now add a partition:
```
sudo fdisk /dev/sda
```
Enter 'n' for new partition and accept all defaults. Enter w to write (confirm)

Now format the partion as NTFS, installing ntfs first
```
sudo apt install ntfs-3g

sudo mkfs.ntfs /dev/sda3
```
Get the UUID, so that mounting can be configured (this might only be available after a reboot).
```
blkid /dev/sda3
```
with that UUID, add a line to the config
```
sudo nano /etc/fstab

/dev/disk/by-uuid/XXXXXXXX /shared ntfs defaults 0 1
```

Reboot and check the directory is available.

Now install samba for file sharing.
```
sudo apt install samba
```
Enable the sparkadmin user as samba user, create password for sharing (it will prompt for a password)
```
sudo smbpasswd -a sparkadmin
```



## create ssh keys, configure ssh server on ubuntu server
This will enable running remote shell scripts without being prompted for a password.

On the windows host navigate to %USERPROFILE%\.ssh, run sshkeygen
enter sparkplayground as file name
accept empty passphrase

On the ubuntu server, configure ssh:
```
sudo nano /etc/ssh/sshd_config
```
Enable (uncomment) these settings:
```
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/authorized_keys
PasswordAuthentication yes
```

now edit the authorized_keys file
```
sudo nano ~.ssh/authorized_keys
```
paste the contents from %USERPROFILE%\.ssh\sparkplayground.pub

## Running scripts
From the solution root, run the powershell scripts to install

```
.\local\deploy_resources.ps1

.\local\install_java.ps1

.\local\install_spark.ps1

.\\local\install_ivy.ps1

.\\local\install_derby.ps1

\\local\install_delta.ps1

.\\local\install_jupyter.ps1
```
