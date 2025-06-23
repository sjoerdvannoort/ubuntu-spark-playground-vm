# ubuntu-spark-playground-vm
script and instructions to create an ubuntu hyper-V image with a spark/jupyter stack

## create ssh keys, configure ssh server on ubuntu server
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
