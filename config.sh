#!/usr/bin/sh
sudo yum update -y
sudo yum install -y epel-release git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel mariadb-devel mariadb
cd ~
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="~/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="~/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
#sudo chown -R vagrant:vagrant ~/.rbenv
source ~/.bash_profile
rbenv install -v 2.4.1
rbenv rehash
rbenv global 2.4.1
gem install bundler
gem install rails -v 5.1.3
gem install mysql2
rbenv rehash
sudo rpm -ivh https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm
sudo yum -y install nodejs
# Do visit https://bugs.centos.org/view.php?id=13669&nbn=1 for more info.
