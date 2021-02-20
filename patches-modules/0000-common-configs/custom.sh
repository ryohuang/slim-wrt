#!/bin/bash

# all the custom scripts will run in their own path.
cd $SLIM_CFG_WORK_PATH
./scripts/feeds update slim
./scripts/feeds install -a -p slim
cd $SLIM_CFG_TOP_DIR