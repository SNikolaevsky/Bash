#!/bin/sh

# taking client-name git log
clientname=$1
client="$clientname : $(cd ./$clientname; git log -1 --pretty=format:"%H%x09%an%x09%ad%x09%D") \n"
shift

# taking OneTick build number
env_file=~/$clientname/client_data/config/env_$clientname.txt
source "$env_file"
onetick="Onetick : $(grep -m 1 "BUILD_" ${MAIN_ONE_TICK_DIR}/ReleaseNotes.txt) \n"

result="Name : $clientname $HOSTNAME\n"
result+="$onetick$client"

# taking other verticals git logs
for var in "$@"
do
    result+="$var : $(cd ./$clientname/$var; git log -1 --pretty=format:"%H%x09%an%x09%ad%x09%D") \n"
done

result+="crontab:\n$(crontab -l) \n"
result+="\n--------------------------------------------------------------------------------------------------------\n"

# push result back to jenkins job workspace
echo -e "$result" | ssh jenkins@172.16.1.75 "cat >> ~/workspace/monitoring/client_version_monitoring/result.log"

# self-delete script
rm -- "$0"
