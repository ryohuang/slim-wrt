#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

# copy fullcone package
cp -rf ${PWD}/openwrt-fullconenat $SLIM_CFG_WORK_PATH/package

# copy kernle patch for fullcone
cp -rf ${PWD}/misc/952-net-conntrack-events-support-multiple-registrant.patch $SLIM_CFG_WORK_PATH/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
