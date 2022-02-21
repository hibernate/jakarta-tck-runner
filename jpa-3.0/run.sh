#!/bin/bash

SCRIPT_DIR=`pwd`

if [ "x$NO_SLEEP" != "x" ]; then
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> NOOOO SLEEEP"
	git apply ${SCRIPT_DIR}/no-sleep.patch
fi

${SCRIPT_DIR}/setupDerby.sh
${SCRIPT_DIR}/runTests $TEST_PATH
