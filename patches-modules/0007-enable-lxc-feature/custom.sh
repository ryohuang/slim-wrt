#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

KERNEL_VERSION=4.14

# only apply this patch for lxc profiles.
if [[ $SLIM_CFG_PROFILE == *"lxc"* ]]; then
    sed  -i "s/# CONFIG_IKCONFIG is not set/CONFIG_IKCONFIG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
    sed  -i "s/# CONFIG_IKCONFIG_PROC is not set/CONFIG_IKCONFIG_PROC=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
fi
