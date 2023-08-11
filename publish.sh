#!/bin/sh
set -eu

ssh -V

echo -e "${INPUT_KEY}" >__TEMP_INPUT_KEY_FILE
chmod 600 __TEMP_INPUT_KEY_FILE
scp -v -s -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -i __TEMP_INPUT_KEY_FILE -r ${INPUT_SRC} "${INPUT_USER}"@pgs.sh:/"${INPUT_PROJECT}"
