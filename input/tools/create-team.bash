#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Usage: $0 <base-dir> <team-name> {private|public}"
    exit 1
fi
BASE_DIR=${1}
TEAM_NAME=${2}
PRIV=${3}

if [ -d ${BASE_DIR} ]
then
    :
else
    mkdir ${BASE_DIR}
fi
if [ -d ${BASE_DIR}/teams ]
then
    :
else
    mkdir ${BASE_DIR}/teams
fi

if [ -d ${BASE_DIR}/teams/${TEAM_NAME} ]
then
    :
else
    mkdir ${BASE_DIR}/teams/${TEAM_NAME}
fi

echo "${TEAM_NAME}:${TEAM_NAME}:${PRIV}" > ${BASE_DIR}/teams/${TEAM_NAME}/team.txt
