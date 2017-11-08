#!/bin/bash

EXPECTED_ARGS=3
E_BADARGS=65
MYSQL=`which mysql`

Q1="CREATE DATABASE IF NOT EXISTS $3 DEFAULT CHARACTER SET UTF8;"
Q2="GRANT ALL ON $3.* TO '$1'@'%' IDENTIFIED BY '$2';"
Q3="GRANT ALL ON $3.* TO '$1'@'localhost' IDENTIFIED BY '$2';"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

if [ $# -ne $EXPECTED_ARGS ] then
  echo "Usage: $0 dbuser dbpass dbname"
  exit $E_BADARGS
fi

$MYSQL -uroot -p -e "$SQL"
