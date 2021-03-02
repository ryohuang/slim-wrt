#!/bin/bash

# append slimapps
if grep -q "slim" $SLIM_CFG_WORK_PATH/feeds.conf.default
then
    echo "Already exit slimapps"
else
    cat <<EOT >> $SLIM_CFG_WORK_PATH/feeds.conf.default

src-cpy slim  ../slimapps
src-git diskman https://github.com/lisaac/luci-app-diskman.git^975859fb7030ded885287c312a8127333f656930

EOT
fi

# all the custom scripts will run in their own path.
cd $SLIM_CFG_WORK_PATH
./scripts/feeds update slim
./scripts/feeds install -a -p slim
# diskman depends on parted
mkdir -p package/parted && wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/parted/Makefile
./scripts/feeds update diskman
./scripts/feeds install -a -p diskman
cd $SLIM_CFG_TOP_DIR