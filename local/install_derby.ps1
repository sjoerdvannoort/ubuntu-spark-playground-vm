if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
# copy the service file
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/derbyns.service" sparkadmin@sparkplayground.mshome.net:~/derbyns.service

$pwd_line = @("PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)")
$script_lines = type remote\install_derby.sh
($pwd_line + $script_lines) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

