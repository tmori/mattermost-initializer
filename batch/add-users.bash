#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <team-users.txt>"
    exit 1
fi

USERS=${1}
source env/env.bash

for user_info in `cat ${USERS}`
do
    USER_NAME=`echo ${user_info} | awk -F: '{print $1}'`
    PASSWD=`echo ${user_info} | awk -F: '{print $2}'`
    EMAIL=`echo ${user_info} | awk -F: '{print $3}'`
    ROLE=`echo ${user_info} | awk -F: '{print $4}'`
    do_cmd "${MATTERMOST_CMD} user create --email ${EMAIL} --username ${USER_NAME} --password ${PASSWD} --local"
    if [ "${ROLE}" = "system_admin" ]
    then
        do_cmd "${MATTERMOST_CMD} roles system_admin ${USER_NAME} --local"
    else
        do_cmd "${MATTERMOST_CMD} roles member ${USER_NAME} --local"
    fi
done
