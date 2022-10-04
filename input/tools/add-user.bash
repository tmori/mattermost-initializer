#!/bin/bash

if [ $# -ne 5 ]
then
    echo "Usage: $0 <base-dir> <team-name> <channel-name> <user-name> {member|system_admin}"
    exit 1
fi

source env/env.bash

BASE_DIR=${1}
TEAM_NAME=${2}
CHANNEL_NAME=${3}
USER_NAME=${4}
PRIV=${5}

if [ -d ${BASE_DIR}/teams/${TEAM_NAME}/channel ]
then
    :
else
    echo "ERROR: not found ${BASE_DIR}/teams/${TEAM_NAME}/channel"
    exit 1
fi

USER_DATA="${USER_NAME}:${MATTERMOST_USER_PASSWD}:${USER_NAME}@example.com:${PRIV}"

# team-users.txt
echo ${USER_DATA} >> ${BASE_DIR}/teams/${TEAM_NAME}/team-users.txt
cat ${BASE_DIR}/teams/${TEAM_NAME}/team-users.txt | sort | uniq > tmp
mv tmp  ${BASE_DIR}/teams/${TEAM_NAME}/team-users.txt

# <team>.txt
echo "user/${USER_NAME}.txt" >> ${BASE_DIR}/teams/${TEAM_NAME}/${TEAM_NAME}.txt
cat  ${BASE_DIR}/teams/${TEAM_NAME}/${TEAM_NAME}.txt | sort | uniq > tmp
mv tmp ${BASE_DIR}/teams/${TEAM_NAME}/${TEAM_NAME}.txt

# <channel>.txt
echo "user/${USER_NAME}.txt" >> ${BASE_DIR}/teams/${TEAM_NAME}/channel/${CHANNEL_NAME}.txt
cat  ${BASE_DIR}/teams/${TEAM_NAME}/channel/${CHANNEL_NAME}.txt | sort | uniq > tmp
mv tmp ${BASE_DIR}/teams/${TEAM_NAME}/channel/${CHANNEL_NAME}.txt

# <user>.txt
echo ${USER_DATA} > ${BASE_DIR}/user/${USER_NAME}.txt
