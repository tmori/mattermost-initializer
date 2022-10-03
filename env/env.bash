#!/bin/bash

export MATTERMOST_CMD_PATH=/opt/mattermost/bin
export MATTERMOST_CMD=${MATTERMOST_CMD_PATH}/mmctl

export PRIVATE_OPTION=
function get_private_option()
{
    PRIVATE_OPTION=
    if [ "${1}" = "private" ]
    then
        PRIVATE_OPTION="--private"
    fi
}
