#!/bin/sh
# 
###############################################################################################
# Buildscript zu erstellung der Images
# 
# Dieses Script holt die passende Gluon-Version von GitHub und �bertr�gt die Gluon-Konfiguration
#
# Das Script ben�tigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
###############################################################################################
 
# Bei Ausf�hrung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi


# Verzeichnis f�r Gluon-Repo erstellen und initialisieren   

if [ ! -d "$WORKSPACE/gluon" ]; then
  git clone https://github.com/freifunk-gluon/gluon.git $WORKSPACE/gluon
fi


# Gluon Repo aktualisieren 

cd $WORKSPACE/gluon
git fetch 
git checkout $1

# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuellen Werte ersetzt

if [ -d $WORKSPACE/gluon/site  ]; then
  rm -r $WORKSPACE/gluon/site
fi

mkdir $WORKSPACE/gluon/site 

cp -r $WORKSPACE/site.mk $WORKSPACE/site.conf $WORKSPACE/modules $WORKSPACE/i18n $WORKSPACE/gluon/site
