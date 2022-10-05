#!/bin/bash

if [ $# -ne 1 -a $# -ne 2 ]
then
    echo "Usage: $0 <user-num> [exec_dir]"
    exit 1
fi
USER_NUM=${1}

if [ $# -eq 2 ]
then
    EXEC_DIR=${2}
    cd ${EXEC_DIR}
fi

if [ -z ${MATTERMOST_BATCH_INPUT_DIR} ]
then
    source env/env.bash
fi

function create_team()
{
    local team_name=${1}
    local channel_name=${2}
    local priv=${3}
    # team
    bash input/tools/create-team.bash       ${MATTERMOST_BATCH_INPUT_DIR} ${team_name} ${priv}
    # channel
    bash input/tools/create-channel.bash    ${MATTERMOST_BATCH_INPUT_DIR}  ${team_name} ${channel_name}  ${priv}
    # users
    bash input/tools/add-user.bash ${MATTERMOST_BATCH_INPUT_DIR} ${team_name} ${channel_name} root system_admin
    for id in `seq ${USER_NUM}`
    do
        bash input/tools/add-user.bash ${MATTERMOST_BATCH_INPUT_DIR} ${team_name} ${channel_name} user-${id} member
    done
}

bash input/tools/reset.bash input/base-data

create_team private-room pchannel-01 private
create_team public-room  channel-01  public

