#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 <base-dir>"
    exit 1
fi
BASE_DIR=${1}

if [ -d ${BASE_DIR} ]
then
    :
else
    echo "ERROR: can not found ${BASE_DIR}"
    exit 1
fi

rm -rf ${BASE_DIR}/teams
rm -rf ${BASE_DIR}/user

mkdir ${BASE_DIR}/teams
mkdir ${BASE_DIR}/user
