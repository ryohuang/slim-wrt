#!/bin/bash

# append slimapps
if grep -q "slim" $SLIM_CFG_WORK_PATH/feeds.conf.default
then
    echo "Already exit slimapps"
else
    cat <<EOT >> $SLIM_CFG_WORK_PATH/feeds.conf.default

src-cpy slim  ../slimapps

EOT
fi

# all the custom scripts will run in their own path.
cd $SLIM_CFG_WORK_PATH
./scripts/feeds update slim
./scripts/feeds install -a -p slim
cd $SLIM_CFG_TOP_DIR