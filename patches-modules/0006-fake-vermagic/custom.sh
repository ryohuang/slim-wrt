#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

# Replace SLIM_FAKE_VERMAGIC in the config file.
sed -i "s/SLIM_FAKE_VERMAGIC/$SLIM_FAKE_VERMAGIC/g" $SLIM_CFG_WORK_PATH/include/kernel-defaults.mk

