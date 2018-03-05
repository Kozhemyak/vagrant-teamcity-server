#!/usr/bin/env bash

# Not the best practies
set -e

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/


# Main body of script
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

add-apt-repository -y ppa:webupd8team/java
apt-get update
apt-get install -y curl git oracle-java8-installer oracle-java8-set-default

#wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz


# End of script