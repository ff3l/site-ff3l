#!/bin/sh
# 
###############################################################################################
# Buildscript zu erstellung Manifest-dateien für den Autoupdater
# 
# Dieses Script wird nach dem Erstellen der Images ausgeführt und erstellt
# die Manifest-Dateien mit den Signaturen des Autoupdater. 
# Es werden insgesamt 3 manifest-Dateien erstellt. 
#
# Für die Signierung muss das Tool Tool 'ecdsasign' vverfügbar sein.
# Repo: https://github.com/tcatm/ecdsautils
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - Datei, die den Schlüssel für die Signierung enthält (z.B. ~/secret)
#
###############################################################################################

# Releasenummer der zu erstellenden Images
case "$3" in
experimental)
        GLUON_RELEASE=$1+$2-exp
        ;;
beta)
        GLUON_RELEASE=$1+$2-beta
        ;;
stable)
        GLUON_RELEASE=$1+$2-stable
        ;;
*)
        GLUON_RELEASE=$1+$2
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
