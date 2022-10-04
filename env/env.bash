#!/bin/bash

export DB_TOOL_PATH=`pwd`/db-backup-restore
export MATTERMOST_CMD_PATH=/opt/mattermost/bin
export MATTERMOST_CMD=${MATTERMOST_CMD_PATH}/mmctl
export MATTERMOST_DBNAME=mattermost

export MATTERMOST_ACCOUNT_NAME=mattermost
export MATTERMOST_USER_PASSWD=Password-999
export MATTERMOST_BATCH_INPUT_DIR=input/base-data

source ${DB_TOOL_PATH}/env/env.bash

export PRIVATE_OPTION=
function get_private_option()
{
    PRIVATE_OPTION=
    if [ "${1}" = "private" ]
    then
        PRIVATE_OPTION="--private"
    fi
}
