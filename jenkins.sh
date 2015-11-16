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

# Beim Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

letzterBefehlErfolgreich () {
        ERROR=$?
        if [ $ERROR != 0 ]
        then
                echo "Etwas ist schief gelaufen. Beende Kompilierungsprozess, Exitstatus $ERROR."
                exit $ERROR;
        fi
}

. ./settings.conf

BUILD_DIR=$WORKSPACE/gluon-$GLUON_COMMIT

# Vorbereitung des Build-Verzeichnisses
cd $WORKSPACE

# Verzeichnis für Gluon-Repo erstellen und initialisieren
if [ ! -d "$BUILD_DIR" ]; then
  git clone $GLUON_URL $BUILD_DIR
  letzterBefehlErfolgreich;
else
  # Alte Images zuvor löschen
  rm -rf $BUILD_DIR/$IMAGE_DIR/*
fi

# Gluon Repo aktualisieren
cd $BUILD_DIR
git fetch
letzterBefehlErfolgreich;
git checkout $GLUON_COMMIT
letzterBefehlErfolgreich;

# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuelle Werte ersetzt
if [ -d $BUILD_DIR/site ]; then
        rm -rf $BUILD_DIR/site
fi

mkdir $BUILD_DIR/site

cp -r $WORKSPACE/site.mk $WORKSPACE/site.conf $WORKSPACE/i18n $BUILD_DIR/site
letzterBefehlErfolgreich;

# Wieder zurück wechseln
cd $WORKSPACE

# Targets, die gebaut werden sollen
declare -a TARGETS

readarray TARGETS < ./targets

for TARGET in ${TARGETS[@]}
do
    if [[ "$TARGET" != \#* ]]; then
        cd $BUILD_DIR
        make update GLUON_RELEASE=$GLUON_RELEASE GLUON_TARGET=$TARGET $JOBS V=s
        make clean GLUON_RELEASE=$GLUON_RELEASE GLUON_TARGET=$TARGET $JOBS V=s

        unset SED
        make GLUON_RELEASE=$GLUON_RELEASE GLUON_TARGET=$TARGET GLUON_BRANCH=$GLUON_BRANCH BROKEN=$GLUON_BROKEN $JOBS V=s
        letzterBefehlErfolgreich;
    fi
done

# Wieder zurück wechseln
cd $WORKSPACE

cd $BUILD_DIR

# Manifest erstellen
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH GLUON_PRIORITY=$GLUON_PRIORITY BROKEN=$GLUON_BROKEN

# Manifest signieren
sh contrib/sign.sh $JENKINS_HOME/gluon/signkeys/jenkins.key $IMAGE_DIR/sysupgrade/$GLUON_BRANCH.manifest

# Aktuell erstellte Images werden in ein Archiv gespeichert
cd $WORKSPACE
echo "Copy images to archive"
mkdir -p $JENKINS_HOME/gluon/archive/$GLUON_BRANCH/build-$FF3L_BUILD_NUMBER
/bin/cp -rv $BUILD_DIR/$IMAGE_DIR/* $JENKINS_HOME/gluon/archive/$GLUON_BRANCH/build-$FF3L_BUILD_NUMBER/

# Symbolische Verlinkung
rm -f $WORKSPACE/images-archive
ln -sf $JENKINS_HOME/gluon/archive/$GLUON_BRANCH $WORKSPACE/images-archive
