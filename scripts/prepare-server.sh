#!/usr/bin/env bash


# Update Repositories
apt-get update
apt-get install -y curl git

VAGRANT_DISTR=/vagrant/.artifactory
TC_INSTALLPATH=/opt/JetBrains
JAVA_INSTALLPATH=/opt/java

echo "[INFO] Check teamcity's possible versions"
TC_DONWLOADLINK=$(wget -q -O - "https://confluence.jetbrains.com/display/TW/Previous+Releases+Downloads" | 
  grep -i -o -E "htt(p|ps):\/\/download.jetbrains.com\/teamcity\/\S*\.tar.gz" |
  head -1)

if [ ! -z "$TC_DONWLOADLINK" ]
then
	echo "[INFO] Installation has been started..."
	TC_ARCHIVENAME=$(basename $TC_DONWLOADLINK)
	
	# Prepare directory to store artifactory
	mkdir -p $VAGRANT_DISTR
	
	# Download TeanCity if needed
	if [ -f $VAGRANT_DISTR/$TC_ARCHIVENAME ]
	then
	  echo "[INFO] TeamCity Archive File Exists."
	  echo "[INFO] TeamCity Archive Will Be Used from Cache..."
	else
	  echo "[WARNING] TeamCity Archive Doesn't Exist."
	  echo "[INFO] TeamCity Archive Will Be Downdloaded..."
	  wget $TC_DONWLOADLINK -P $VAGRANT_DISTR
	  wget $TC_DONWLOADLINK.sha256 -P $VAGRANT_DISTR
	fi

	# Unpack TeamCity
	if [ ! -f $TC_INSTALLPATH/TeamCity ]
	then
	  echo "[INFO] TeamCity Installing..."
	  mkdir -p $TC_INSTALLPATH
	  tar xfz $VAGRANT_DISTR/$TC_ARCHIVENAME -C $TC_INSTALLPATH
	  
	  export TEAMCITY_HOME=$TC_INSTALLPATH/TeamCity
	  #chown -R vagrant $TC_INSTALLPATH/TeamCity
	else
	  echo "[INFO] TeamCity Has Already Installed!"
	fi

	# Unpack Java
	if [ ! -f $JAVA_INSTALLPATH ]
	then
	  echo "[INFO] Java Installing..."
	  mkdir -p $JAVA_INSTALLPATH

	  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | 
		debconf-set-selections

	  tar xfz $VAGRANT_DISTR/jdk-8u161-linux-x64.tar.gz -C $JAVA_INSTALLPATH

	  export JAVA_HOME=$JAVA_INSTALLPATH/jdk1.8.0_161
	  export JRE_HOME=$JAVA_INSTALLPATH/jdk1.8.0_161/jre
	  export PATH=$PATH:/opt
	else
	  echo "[INFO] Java Has Already Installed!"
	fi
	
	echo "[INFO] Copy ENV paraments"
	cp -f /vagrant/scripts/vagrant-envs.sh /etc/profile.d
	
	echo "[INFO] Starting TeamCity Server and Agent"
	export TEAMCITY_DATA_PATH=/vagrant/.BuildServer
	mkdir -p $TEAMCITY_DATA_PATH
	sh /opt/JetBrains/TeamCity/bin/runAll.sh start
	
else
	echo "[ERROR] Machine does not have access to Internet,"
	echo "[ERROR] or link 'TC_DONWLOADLINK' is not accesible any more"
fi



