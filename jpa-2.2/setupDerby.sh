#!/bin/bash

SCRIPT_DIR=`pwd`

echo "Creating (if it does not exist) ${DERBY_DATA_DIR}"
mkdir -p ${DERBY_DATA_DIR}
echo "Creating (if it does not exist) ${DERBY_LOG_DIR}"
mkdir -p ${DERBY_LOG_DIR}

echo "Deleting database (if it exists): ${DERBY_DATA_DIR}/derbyDB"
rm -rf ${DERBY_DATA_DIR}/derbyDB

echo "Starting Derby"
${SCRIPT_DIR}/startDerby

${SCRIPT_DIR}/cleandb

