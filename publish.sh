#!/bin/sh -l
set -x

ssh -V

echo -e "${INPUT_KEY}" > __TEMP_INPUT_KEY_FILE

chmod 600 __TEMP_INPUT_KEY_FILE

scp -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -v -i __TEMP_INPUT_KEY_FILE -r ${INPUT_SRC} "${INPUT_USER}"@pgs.sh:/"${INPUT_PROJECT}"
