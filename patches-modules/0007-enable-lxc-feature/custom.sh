#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

# CONFIG_IKCONFIG is not set
# CONFIG_IKCONFIG_PROC is not set

sed  -i "s/# CONFIG_IKCONFIG is not set/CONFIG_IKCONFIG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-4.14
sed  -i "s/# CONFIG_IKCONFIG_PROC is not set/CONFIG_IKCONFIG_PROC=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-4.14