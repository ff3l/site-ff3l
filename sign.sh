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
testing)
        GLUON_RELEASE=$6+$2-test
        GLUON_BROKEN=1
        ;;
experimental)
        GLUON_RELEASE=$6+$2-exp
        GLUON_BROKEN=1
        ;;
beta)
        GLUON_RELEASE=$6+$2-beta
        GLUON_BROKEN=0
        ;;
stable)
        GLUON_RELEASE=$6+$2-stable
        GLUON_BROKEN=0
        ;;
*)
        GLUON_RELEASE=$6+$2
        GLUON_BROKEN=0
        ;;
esac

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

cd $WORKSPACE/gluon-$1

# Manifeste erstellen 
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$3 GLUON_PRIORITY=$5 BROKEN=$GLUON_BROKEN
#make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=beta GLUON_PRIORITY=1
#make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=stable GLUON_PRIORITY=3

# Manifeste signieren 
sh contrib/sign.sh $4 images/sysupgrade/$3.manifest
#sh contrib/sign.sh $4 images/sysupgrade/beta.manifest
#sh contrib/sign.sh $4 images/sysupgrade/stable.manifest
