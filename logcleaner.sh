#!/bin/bash

#sergey.nikolaevsky@onetick.com

#d1=14  #(lifetime for UAT logs)
#d2=28  #(lifetime for PROD logs)
#DAYS=$LOGS_LIFETIME
#LPATH=$MAIN_LOG_DIR,$CATALINA_HOME/logs/
LPATH1=$MAIN_LOG_DIR
LPATH2=$CATALINA_HOME/logs/
#LPATH3=~/Log
#LPATH4=~/logs

if [ "$LOGS_LIFETIME" ]; then
DAYS=$LOGS_LIFETIME
else
DAYS="20"
fi

#echo $DAYS

find $LPATH1 $LPATH2 -type f -mtime +$DAYS
find $LPATH1 $LPATH2 -type f -mtime +$DAYS -exec rm -f {} \;


#find $LPATH1 $LPATH2 $LPATH3 $LPATH4 -type f -mtime +$1 -print0| xargs -0
#rm -f
