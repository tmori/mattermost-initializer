#!/bin/bash

if [ $# -eq 1 ]
then
    EXEC_DIR=${1}
    cd ${EXEC_DIR}
fi

source env/env.bash

bash bin/mm-status.bash  | grep Active | grep running
if [ $? -eq 0 ]
then
    echo "ERROR: mattermost is running. please stop this service"
    exit 1
fi

echo "INFO: Initializing DB"
(cd ${DB_TOOL_PATH} && bash bin/db_drop.bash ${MATTERMOST_DBNAME})
(cd ${DB_TOOL_PATH} && bash bin/db_create.bash ${MATTERMOST_DBNAME})

echo "INFO: Creating DB..."
bash bin/mm-start.bash
bash bin/mm-stop.bash
echo "INFO: DONE"
