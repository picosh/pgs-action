#!/bin/bash

echo -e "${INPUT_KEY}" >__TEMP_INPUT_KEY_FILE

chmod 600 __TEMP_INPUT_KEY_FILE

scp -s -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -v -i __TEMP_INPUT_KEY_FILE -r ${INPUT_SRC} "${INPUT_USER}"@pgs.sh:/"${INPUT_PROJECT}"
