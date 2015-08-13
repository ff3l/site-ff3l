#!/bin/sh
# 
###############################################################################################
# Buildscript zu erstellung der Images
# 
# Dieses Script holt die passende Gluon-Version von GitHub und überträgt die Gluon-Konfiguration
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - URL des Gluon-Repositories (z.B. https://github.com/freifunk-gluon/gluon.git)
###############################################################################################

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi


# Verzeichnis für Gluon-Repo erstellen und initialisieren

if [ ! -d "$WORKSPACE/gluon-$1" ]; then
	git clone $2 $WORKSPACE/gluon-$1
	JOBS='-j 1'
else
	# Alte Images zuvor löschen
	rm -rf $WORKSPACE/gluon-$1/images/*
	JOBS='-j 8'
fi

# Gluon Repo aktualisieren

cd $WORKSPACE/gluon-$1
git fetch
git checkout $1


# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuelle Werte ersetzt

if [ -d $WORKSPACE/gluon-$1/site ]; then
	rm -rf $WORKSPACE/gluon-$1/site
fi

mkdir $WORKSPACE/gluon-$1/site

cp -r $WORKSPACE/site.mk $WORKSPACE/site.conf $WORKSPACE/gluon-$1/site

echo $JOBS
