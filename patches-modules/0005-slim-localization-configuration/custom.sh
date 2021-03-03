#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

# copy fullcone package
cp -rf ${PWD}/slim-localization $SLIM_CFG_WORK_PATH/package
