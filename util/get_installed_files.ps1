if (!$env:SPARKPLAYGROUND_SUDO_PWD){
     $env:SPARKPLAYGROUND_SUDO_PWD = Read-Host "Enter sudo password" -MaskInput
}
$mv_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S cp /root/.ipython/profile_default/startup/10-sparksession.py ~"
)
($mv_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

<#
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/sparkthrift.service "resources/sparkthrift.service"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/derby/derbyns.service "resources/derbyns.service"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:10-sparksession.py "resources/10-sparksession.py"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/etc/samba/smb.conf "resources/smb.conf"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/start-thrift.sh "resources/start-thrift.sh"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/sparkplayground/start-thrift.sh "resources/stop-thrift.sh"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/etc/systemd/jupyternb.service "resources/jupyternb.service"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/welcome.ipynb "resources/notebooks/welcome.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/sales_demo/create_sales_demo_tables.ipynb "resources/notebooks/create_sales_demo_tables.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/pyspark/create_landing.ipynb "resources/notebooks/create_landing.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/pyspark/query_derby_hive_metastore.ipynb "resources/notebooks/query_derby_hive_metastore.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/sparksql/create_managed_table.ipynb "resources/notebooks/create_managed_table.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/notebooks/sparksql/show_tables.ipynb "resources/notebooks/show_tables.ipynb"
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/shared/sourcedata/commercial_property/commercial_property_snapshots_100_M39.csv "resources/commercial_property_snapshots_100_M39.csv"
#>
scp -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net:/opt/jupyternb/etc/jupyter/jupyter_notebook_config.py "resources/jupyter_notebook_config.py"
$mv_file = @(
    "PASSWORD=$($env:SPARKPLAYGROUND_SUDO_PWD)",
    "echo `$PASSWORD | sudo -S rm 10-sparksession.py"
)
($mv_file) | ssh -i "$($env:USERPROFILE)\.ssh\sparkplayground" sparkadmin@sparkplayground.mshome.net "tr -d '\r' | bash -s"

