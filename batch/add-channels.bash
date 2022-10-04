#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <channels.txt>"
    exit 1
fi

CHANNELS=${1}
source env/env.bash

for channel_info in `cat ${CHANNELS}`
do
    TEAM_NAME=`echo ${channel_info} | awk -F: '{print $1}'`
    CHANNEL_NAME=`echo ${channel_info} | awk -F: '{print $2}'`
    CHANNEL_DNAME=`echo ${channel_info} | awk -F: '{print $3}'`
    PRIVATE_OPT=`echo ${channel_info} | awk -F: '{print $4}'`

    get_private_option ${PRIVATE_OPT}
    su ${MATTERMOST_ACCOUNT_NAME} -c "${MATTERMOST_CMD} channel create --team ${TEAM_NAME} --name  ${CHANNEL_NAME} --display-name ${CHANNEL_DNAME} ${PRIVATE_OPTION} --local"
done

