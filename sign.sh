#!/bin/sh
# 
###############################################################################################
# Buildscript zu Erstellung Manifest-Dateien für den Autoupdater
# 
# Dieses Script wird nach der Kompilation der Images ausgeführt und erstellt
# die Manifest-Dateien mit den Signaturen des Autoupdater. 
# Es werden insgesamt 3 Manifest-Dateien angelegt. 
#
# Für die Signierung muss das Tool 'ecdsasign' verfügbar sein.
# Repo: https://github.com/tcatm/ecdsautils
#
# Folgende Kommandozeilenparameter werden benötigt:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - Datei, die den Schlüssel für die Signierung enthält (z.B. ~/secret)
#
###############################################################################################

# Releasenummer der zu erstellenden Images
case "$3" in
experimental)
        GLUON_RELEASE=$1.0+$2-exp
        ;;
beta)
        GLUON_RELEASE=$1.0+$2-beta
        ;;
stable)
        GLUON_RELEASE=$1.0+$2-stable
        ;;
*)
        GLUON_RELEASE=$1.0+$2
        ;;
esac

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

cd $WORKSPACE/gluon-$1

# Manifeste erstellen 
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$3 GLUON_PRIORITY=$5
#make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=beta GLUON_PRIORITY=1
#make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=stable GLUON_PRIORITY=3

# Manifeste signieren 
sh contrib/sign.sh $4 images/sysupgrade/$3.manifest
#sh contrib/sign.sh $4 images/sysupgrade/beta.manifest
#sh contrib/sign.sh $4 images/sysupgrade/stable.manifest
