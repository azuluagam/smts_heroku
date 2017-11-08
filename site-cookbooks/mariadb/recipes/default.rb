# update package database
execute "sudo yum update"

# install packages
package "mariadb"
package "mariadb-server"

execute "sudo systemctl start mariadb"
execute "sudo systemctl status mariadb"
execute "sudo systemctl enable mariadb"
