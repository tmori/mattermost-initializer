#!/bin/bash

if [ $# -eq 1 ]
then
    EXEC_DIR=${1}
    cd ${EXEC_DIR}
fi

if [ -z ${MATTERMOST_BATCH_INPUT_DIR} ]
then
    source env/env.bash
fi

cat ${MATTERMOST_BATCH_INPUT_DIR}/teams/*/team-users.txt | sort | uniq > tmp
#add users on db
echo "INFO: add users on db:"
bash batch/add-users.bash tmp
rm -f tmp

for team in `ls ${MATTERMOST_BATCH_INPUT_DIR}/teams`
do
    bash batch/setup-one.bash $team 2> /dev/null
done
