#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <team.txt>"
    exit 1
fi

TEAMS=${1}
source env/env.bash

for team_info in `cat ${TEAMS}`
do
    TEAM_NAME=`echo ${team_info} | awk -F: '{print $1}'`
    DISP_NAME=`echo ${team_info} | awk -F: '{print $2}'`
    PRIVATE_OPT=`echo ${team_info} | awk -F: '{print $3}'`
    get_private_option ${PRIVATE_OPT}
    sudo -u ${MATTERMOST_ACCOUNT_NAME} ${MATTERMOST_CMD} \
        team create --name ${TEAM_NAME} \
        --display-name ${DISP_NAME} \
        ${PRIVATE_OPTION} \
        --local
done
