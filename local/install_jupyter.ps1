if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
# copy the service file
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/jupyternb.service" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/systemd/jupyternb.service
# copy ipython int file, then move to directory
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/10-sparksession.py" sparkadmin@sparkplayground.mshome.net:~/10-sparksession.py
$sh_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S mv ~/10-sparksession.py /root/.ipython/profile_default/startup",
    "echo `$PASSWORD | sudo -S apt --yes install python3-pip",
    "pip3 install notebook"
)
($sh_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"
