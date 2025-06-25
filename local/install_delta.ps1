$pwd_string = Read-Host "Enter sudo password" -MaskInput
$pwd_line = @("PASSWORD=$($pwd_string)")
$script_lines = type remote\install_delta.sh
($pwd_line + $script_lines) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"
