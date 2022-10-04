#!/bin/bash

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
    for id in `seq 10`
    do
        bash input/tools/add-user.bash ${MATTERMOST_BATCH_INPUT_DIR} ${team_name} ${channel_name} user-${id} member
    done
}


create_team private-room pchannel-01 private
create_team public-room  channel-01  public

