#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

if [[ ! -z $SLIM_FAKE_VERMAGIC ]]
then
    echo "Caution! We will set a fake vermagic now!"
    OLD='grep.*mkhash md5.*vermagic'
    NEW="echo $SLIM_FAKE_VERMAGIC > \$(LINUX_DIR)/.vermagic"
    sed  -i 's@'"$OLD"'@'"$NEW"'@' $SLIM_CFG_WORK_PATH/include/kernel-defaults.mk
fi