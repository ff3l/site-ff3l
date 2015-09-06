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
# - Gluon-Commit (z.B. ff3l-v2015.1.2)
# - Build-Nummer (z.B. 114)
# - Datei, die den Schlüssel für die Signierung enthält (z.B. ~/secret)
# - Gluon-Version (z.B. v2015.1.2)
#
###############################################################################################

# Releasenummer der zu erstellenden Images
case "$3" in
experimental)
        GLUON_RELEASE=$1+$6-exp
        ;;
beta)
        GLUON_RELEASE=$1+$6-beta
        ;;
stable)
        GLUON_RELEASE=$1+$6-stable
        ;;
*)
        GLUON_RELEASE=$1+$6
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
