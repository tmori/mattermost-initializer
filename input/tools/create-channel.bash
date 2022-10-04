#!/bin/bash

if [ $# -ne 4 ]
then
    echo "Usage: $0 <base-dir> <team-name> <channel-name> {private|public}"
    exit 1
fi
BASE_DIR=${1}
TEAM_NAME=${2}
CHANNEL_NAME=${3}
PRIV=${4}

if [ -d ${BASE_DIR}/teams/${TEAM_NAME} ]
then
    :
else
    echo "ERROR: not found ${TEAM_NAME}"
    exit 1
fi

if [ -d ${BASE_DIR}/teams/${TEAM_NAME}/${CHANNEL_NAME} ]
then
    :
else
    mkdir ${BASE_DIR}/teams/${TEAM_NAME}/${CHANNEL_NAME}
fi

echo "${TEAM_NAME}:${CHANNEL_NAME}:${CHANNEL_NAME}:${PRIV}" >>  ${BASE_DIR}/teams/${TEAM_NAME}/channels.txt
cat ${BASE_DIR}/teams/${TEAM_NAME}/channels.txt | sort | uniq > tmp
mv tmp ${BASE_DIR}/teams/${TEAM_NAME}/channels.txt


