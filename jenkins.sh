#!/bin/sh
# 
###############################################################################################
# Jenkins-Buildscript zu Erstellung der Images
# 
# Dieses Script wird nach jedem Push auf dem Freifunk Buildserver ausgführt 
# und erstelt die Images komplett neu.
# Nach dem Build werden auch die Signaturen für den Autoupdater erstellt.
#
# Die URL des Gluon-Repositories sowie der verwendete Commit sind hier fest vorgegeben.
#  
# Durch den Jenkins-Server werden folgende Systemvariablem gesetzt:
# $WORKSPACE - Arbeitsverzeichnis, hierhin wurde dieses repo geclont 
# $JENKINS_HOME - TBD 
# $BUILD_NUMBER - Nummer des aktuellen Buildvorganges (wird in der site.conf verwendet)
#
###############################################################################################

# Globale Einstellungen
GLUON_URL=https://github.com/freifunk-gluon/gluon.git
GLUON_COMMIT=v2014.4
GLUON_BRANCH=experimental
GLUON_PRIORITY=0

# Beim Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

# Images erstellen
cd $WORKSPACE
sh ./build.sh $GLUON_COMMIT $BUILD_NUMBER $GLUON_URL $GLUON_BRANCH V=s


# Manifest für Autoupdater erstellen und mit den Key des Servers unterschreiben 
# Der private Schlüssel des Servers muss in $JENKINS_HOME/secret liegen
cd $WORKSPACE
sh ./sign.sh $GLUON_COMMIT $BUILD_NUMBER $GLUON_BRANCH $JENKINS_HOME/secret $GLUON_PRIORITY
