#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <<team-name>.txt>"
    exit 1
fi

TEAM_NAME=`echo ${1} | awk -F/ '{print $NF}' | awk -F: '{print $NF}' | awk -F. '{print $1}'`
USERS=${1}

source env/env.bash

for user_file in `cat ${USERS}`
do
    user_info_file=${MATTERMOST_BATCH_INPUT_DIR}/${user_file}
    if [ -f ${user_info_file} ]
    then
        :
    else
        echo "ERROR: can not found ${user_info}"
        exit 1
    fi
    user_info=`cat ${user_info_file}`
    USER_NAME=`echo ${user_info} | awk -F: '{print $1}'`
    PASSWD=`echo ${user_info} | awk -F: '{print $2}'`
    EMAIL=`echo ${user_info} | awk -F: '{print $3}'`
    su ${MATTERMOST_ACCOUNT_NAME}  -c "${MATTERMOST_CMD} team users add ${TEAM_NAME} ${EMAIL} ${USER_NAME} --local"
done
