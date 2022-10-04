#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <<channel-name>.txt>"
    exit 1
fi

FILE_NAME=${1}
TEAM_NAME=`echo ${FILE_NAME} | awk -F/  '{print $(NF-2)}'`
CHANNEL_NAME=`echo ${FILE_NAME} | awk -F/ '{print $NF}' | awk -F. '{print $1}'`

source env/env.bash

for user_file in `cat ${FILE_NAME}`
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
    su ${MATTERMOST_ACCOUNT_NAME} -c "${MATTERMOST_CMD} channel users add ${TEAM_NAME}:${CHANNEL_NAME}    ${EMAIL} ${USER_NAME} --local"
done
