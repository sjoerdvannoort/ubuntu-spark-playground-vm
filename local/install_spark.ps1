if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
# copy the thrift server start/stop/service files
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/start-thrift.sh" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sbin/start-thrift.sh
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/stop-thrift.sh" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sbin/stop-thrift.sh
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/sparkthrift.service" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/systemd/sparkthrift.service
$pwd_line = @("PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)")
$script_lines = type remote\install_spark.sh
($pwd_line + $script_lines) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"