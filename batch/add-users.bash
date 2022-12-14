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
    NUM_OPTS=`echo ${user_info} | awk -F: '{print NF}'`
    if [ $NUM_OPTS -eq 4 ]
    then
        do_cmd "${MATTERMOST_CMD} user create --email ${EMAIL} --username ${USER_NAME} --password ${PASSWD} --local"
    elif [ $NUM_OPTS -eq 5 ]
        FIRST_NAME=`echo ${user_info} | awk -F: '{print $5}'`
        do_cmd "${MATTERMOST_CMD} user create --email ${EMAIL} --username ${USER_NAME} --password ${PASSWD} --firstname ${FIRST_NAME} --local"
    fi
    elif [ $NUM_OPTS -eq 6 ]
        FIRST_NAME=`echo ${user_info} | awk -F: '{print $5}'`
        LAST_NAME=`echo ${user_info} | awk -F: '{print $6}'`
        do_cmd "${MATTERMOST_CMD} user create --email ${EMAIL} --username ${USER_NAME} --password ${PASSWD} --firstname ${FIRST_NAME} --lastname ${LAST_NAME} --local"
    else
        echo "ERROR: invalid data: ${user_info}"
    fi
    if [ "${ROLE}" = "system_admin" ]
    then
        do_cmd "${MATTERMOST_CMD} roles system_admin ${USER_NAME} --local"
    else
        do_cmd "${MATTERMOST_CMD} roles member ${USER_NAME} --local"
    fi
done
