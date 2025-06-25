$pwd_string = Read-Host "Enter sudo password" -MaskInput
$pwd_line = @("PASSWORD=$($pwd_string)")
$script_lines = type remote\create_directories.sh
($pwd_line + $script_lines) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"


scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/download_ivy_dependencies.sh" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sbin