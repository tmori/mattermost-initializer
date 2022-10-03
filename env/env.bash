#!/bin/bash

export DB_TOOL_PATH=`pwd`/db-backup-restore
export MATTERMOST_CMD_PATH=/opt/mattermost/bin
export MATTERMOST_CMD=${MATTERMOST_CMD_PATH}/mmctl
export MATTERMOST_DBNAME=mattermost

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
