$pwd_string = Read-Host "Enter sudo password" -MaskInput
$mv_file = @(
    "PASSWORD=$($pwd_string)",
    "echo `$PASSWORD | sudo -S cp /root/.ipython/profile_default/startup/10-sparksession.py ~"
)
($mv_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sparkthrift.service "resources/sparkthrift.service"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/derby/derbyns.service "resources/derbyns.service"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:10-sparksession.py "resources/10-sparksession.py"

$mv_file = @(
    "PASSWORD=$($pwd_string)",
    "echo `$PASSWORD | sudo -S rm 10-sparksession.py"
)
($mv_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

