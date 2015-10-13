#!/bin/sh
#
###############################################################################################
# Buildscript zum manuellen Test des Builds auf dem Buildserver
#
# Dieses Script setzt die Umgebungsvariablen, die sonst von Jenkins gesetzt werden und
# startet dann die build-jenkins.sh
#
#
###############################################################################################
# Based on https://github.com/FreiFunkMuenster/site-ffms/blob/master/build-test.sh
###############################################################################################

# Umgebungsvariablen
export WORKSPACE=`pwd`
export JENKINS_HOME=/var/lib/jenkins
export BUILD_NUMBER=000
export FF3L_BUILD_NUMBER=000
# Jenkins Build-Konfiguration
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
chmod +x $WORKSPACE/jenkins.sh
sh $WORKSPACE/jenkins.sh
