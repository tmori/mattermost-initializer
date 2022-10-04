#!/bin/bash

if [ -z ${MATTERMOST_BATCH_INPUT_DIR} ]
then
    source env/env.bash
fi

TOP_DIR=${MATTERMOST_BATCH_INPUT_DIR}
if [ $# -ne 1 ]
then
    echo "Usage: $0 <team-name>"
    echo "teams:"
    ls ${TOP_DIR}/team/
    exit 1
fi

TEAM_NAME=${1}
TEAM_DIR=${TOP_DIR}/teams/${TEAM_NAME}
if [ -d  ${TEAM_DIR} ]
then
    :
else
    echo "ERROR: can not found dir: ${TEAM_DIR}"
    ls ${TOP_DIR}/teams/
    exit 1
fi

#add team
echo "INFO: add team:"
bash batch/add-teams.bash ${TEAM_DIR}/team.txt

#add users on team
echo "INFO: add users on team:"
bash batch/add-team-users.bash ${TEAM_DIR}/${TEAM_NAME}.txt

#add channels on team
echo "INFO: add channels on team:"
bash batch/add-channels.bash ${TEAM_DIR}/channels.txt

for channel_file in `ls ${TEAM_DIR}/channel`
do
    channel=`echo ${channel_file} | awk -F. '{print $1}'`
    #add users on channels
    echo "INFO: add users on ${channel}:"
    bash batch/add-channel-users.bash ${TEAM_DIR}/channel/${channel_file}
done

echo "INFO: OK"
