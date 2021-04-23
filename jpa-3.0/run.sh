#!/bin/bash

SCRIPT_DIR=`pwd`

if [ "x$NO_SLEEP" != "x" ]; then
	git apply ${SCRIPT_DIR}/no-sleep.patch
fi

${SCRIPT_DIR}/setupDerby.sh
${SCRIPT_DIR}/runSigTests
${SCRIPT_DIR}/runOrmTests
