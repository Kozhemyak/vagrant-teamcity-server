#!/usr/bin/env bash

# Global
export PATH=$PATH:/opt

# Vagrant
export VAGRANT_HOME=/vagrant
export VAGRANT_DISTR=$VAGRANT_HOME/.artifactory

# Java
export JAVA_INSTALLPATH=/opt/java
export JAVA_HOME=$JAVA_INSTALLPATH/jdk1.8.0_161
export JRE_HOME=$JAVA_INSTALLPATH/jdk1.8.0_161/jre

# TeamCity
export TEAMCITY_INSTALLPATH=/opt/JetBrains
export TEAMCITY_HOME=$TEAMCITY_INSTALLPATH/TeamCity
export TEAMCITY_DATA_PATH=$VAGRANT_HOME/.BuildServer