# update package database
execute "sudo yum update"

# install packages
package "git-core"
package "zlib"
package "zlib-devel"
package "gcc-c++"
package "patch"
package "readline"
package "readline-devel"
package "libyaml-devel"
package "openssl-devel"
package "make"
package "bzip2"
package "autoconf"
package "automake"
package "libtool"
package "bison"
package "curl"
package "sqlite-devel"
package "mariadb-devel"
package "mariadb"

execute "cd ~"
execute "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
execute "echo 'export PATH=\"/home/vagrant/.rbenv/bin:$PATH\"' >> ~/.bash_profile"
execute "echo 'eval \"$(rbenv init -)\"' >> ~/.bash_profile"
execute "cd ~"
execute "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"
execute "echo 'export PATH=\"~/.rbenv/plugins/ruby-build/bin:$PATH\"' >> ~/.bash_profile"
execute "sudo chown -R vagrant:vagrant /home/vagrant/.rbenv"

# https://serverfault.com/questions/402881/execute-as-vagrant-user-not-root-with-chef-solo
# The above might be helpful to ensure that chef solo runs as vagrant user.