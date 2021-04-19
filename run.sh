#!/bin/bash

SCRIPT_DIR=`pwd`

${SCRIPT_DIR}/setupDerby.sh
${SCRIPT_DIR}/runSigTests
${SCRIPT_DIR}/runOrmTests
