if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
# create sparkplayground and sub directories
$pwd_line = @("PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)")
$script_lines = type remote\create_directories.sh
($pwd_line + $script_lines) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

# copy the ivy script
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/download_ivy_dependencies.sh" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sbin

# copy samba (fileshare) config to user directory, then move to samba system directory
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" "resources/smb.conf" sparkadmin@sparkplayground.mshome.net:~/smb.conf
$sh_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S mv /etc/samba/smb.conf /etc/samba/smb.conf.original",
    "echo `$PASSWORD | sudo -S mv ~/smb.conf /etc/samba"
)
($sh_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"
