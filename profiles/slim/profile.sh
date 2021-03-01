#!/bin/bash

SLIM_CFG_TARGET="x86"
SLIM_CFG_ARCH="64"

SLIM_CFG_EXCLUDE_PATCH=(\
                        0002-upnp \
                        )

echo ${SLIM_CFG_EXCLUDE_PATCH[*]}

# You can add more exclude patches as following lines.
# SLIM_CFG_EXCLUDE_PATCH=(\
#                         0002-upnp \
#                         0003-nf-conntrack-max \
#                         )

export SLIM_FAKE_VERMAGIC=68143adfcb7fc62a239c4be112fe40de
