#!/bin/bash

SLIM_CFG_TARGET="ramips"
SLIM_CFG_ARCH="mt76x8"

SLIM_CFG_EXCLUDE_PATCH=(\
                        0002-upnp \
                        0001-fullcone-nat \
                        )

echo ${SLIM_CFG_EXCLUDE_PATCH[*]}

# You can add more exclude patches as following lines.
# SLIM_CFG_EXCLUDE_PATCH=(\
#                         0002-upnp \
#                         0003-nf-conntrack-max \
#                         )