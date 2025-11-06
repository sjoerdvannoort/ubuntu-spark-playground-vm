if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
$sh_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S apt install ntfs-3g"
    "echo `$PASSWORD | sudo -S apt install nano"
    "echo `$PASSWORD | sudo -S apt install samba"
)
($sh_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"
