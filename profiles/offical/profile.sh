#!/bin/bash

SLIM_CFG_TARGET="x86"
SLIM_CFG_ARCH="64"

SLIM_CFG_EXCLUDE_PATCH=(\
                        0000-common-configs \
                        0001-fullcone-nat \
                        0002-upnp \
                        0003-nf-conntrack-max \
                        0004-workaround-for-realtime-connection-status-crash \
                        0005-slim-localization-configuration \
                        0006-fake-vermagic \
                        )

