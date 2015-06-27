#!/bin/sh
# 
###############################################################################################
# 
# Dieses Script holt die vorgegebene Gluon-Version in das aktuelle Arbeitsverzeichnis 
# uns erstellt die Images.
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - URL des Gluon-Repositories (z.B. https://github.com/freifunk-gluon/gluon.git)
# - Optionale Parameter für make (z.B. V=s oder -j 4)
#  
###############################################################################################

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

letzterBefehlErfolgreich () {
        ERROR=$?  
	if [ $ERROR != 0 ]
	then
		echo "Etwas ist schief gelaufen. Beende Kompilierungsprozess, Exitstatus $ERROR."
		exit $ERROR;
	fi
}

# Build Verzeichnis vorbereiten
cd $WORKSPACE
JOBS=$(sh ./prepare.sh $1 $3)
letzterBefehlErfolgreich;

#echo $JOBS

# Gluon Pakete aktualisieren und Build ausführen
cd $WORKSPACE
sh ./compile.sh $1 $2 ar71xx-generic $4 $JOBS $5 $6 $7 $8
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 ar71xx-nand $4 $JOBS $5 $6 $7 $8
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 mpc85xx-generic $4 $JOBS $5 $6 $7 $8
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 x86-generic $4 $JOBS $5 $6 $7 $8
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 x86-kvm_guest $4 $JOBS $5 $6 $7 $8
letzterBefehlErfolgreich;
