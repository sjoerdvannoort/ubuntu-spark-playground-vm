if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
# copy the service file
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/jupyternb.service" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/systemd/jupyternb.service
# copy ipython int file, then move to directory
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/10-sparksession.py" sparkadmin@sparkplayground.mshome.net:~/10-sparksession.py
$sh_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S mkdir -p /root/.ipython/profile_default/startup",
    "echo `$PASSWORD | sudo -S mv ~/10-sparksession.py /root/.ipython/profile_default/startup",
    "echo `$PASSWORD | sudo -S apt --yes install python3-pip",
    "echo `$PASSWORD | sudo -S apt --yes install python3-notebook",
    "echo `$PASSWORD | sudo -S pip3 install sparksql-magic --break-system-packages",
    "echo `$PASSWORD | sudo -S pip3 install pandas --break-system-packages",
    "echo `$PASSWORD | sudo -S pip3 install faker --break-system-packages"
)
($sh_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

# copy the welcome notebook
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/notebooks/welcome.ipynb" "sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/notebooks/welcome.ipynb"

# copy commercial_property example data file
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/commercial_property_snapshots_100_M39.csv" "sparkadmin@sparkplayground.mshome.net:/shared/sourcedata/commercial_property/commercial_property_snapshots_100_M39.csv"

# copy the other notebooks
Get-Item .\resources\notebooks\*.ipynb | Where-Object Name -ne "welcome.ipynb" | ForEach-Object {
    &scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "$($_.FullName)" "sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/notebooks/examples/$($_.Name)"
}