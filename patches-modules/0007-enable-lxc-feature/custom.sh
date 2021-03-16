#!/bin/bash

# all the custom scripts will run in their own path.
echo "Script executed from: ${PWD}"

KERNEL_VERSION=4.14
# CONFIG_IKCONFIG is not set
# CONFIG_IKCONFIG_PROC is not set

sed  -i "s/# CONFIG_IKCONFIG is not set/CONFIG_IKCONFIG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
sed  -i "s/# CONFIG_IKCONFIG_PROC is not set/CONFIG_IKCONFIG_PROC=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION

# CONFIG_NAMESPACES is not set
# sed  -i "s/# CONFIG_NAMESPACES is not set/CONFIG_NAMESPACES=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_CGROUPS is not set
# sed  -i "s/# CONFIG_CGROUPS is not set/CONFIG_CGROUPS=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_BPF is not set
# sed  -i "s/# CONFIG_CGROUP_BPF is not set/CONFIG_CGROUP_BPF=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_DEBUG is not set
# sed  -i "s/# CONFIG_CGROUP_DEBUG is not set/CONFIG_CGROUP_DEBUG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_HUGETLB is not set
# sed  -i "s/# CONFIG_CGROUP_HUGETLB is not set/CONFIG_CGROUP_HUGETLB=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_NET_CLASSID is not set
# sed  -i "s/# CONFIG_CGROUP_NET_CLASSID is not set/CONFIG_CGROUP_NET_CLASSID=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_NET_PRIO is not set
# sed  -i "s/# CONFIG_CGROUP_NET_PRIO is not set/CONFIG_CGROUP_NET_PRIO=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_CGROUP_RDMA is not set
# sed  -i "s/# CONFIG_CGROUP_RDMA is not set/CONFIG_CGROUP_RDMA=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION

# # CONFIG_VETH is not set
# sed  -i "s/# CONFIG_VETH is not set/CONFIG_VETH=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_MACVLAN is not set
# sed  -i "s/# CONFIG_MACVLAN is not set/CONFIG_MACVLAN=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
# sed  -i "s/# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set/CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# # CONFIG_FUSE_FS is not set
# sed  -i "s/# CONFIG_FUSE_FS is not set/CONFIG_FUSE_FS=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION

# CONFIG_CHECKPOINT_RESTORE is not set
# sed  -i "s/# CONFIG_CHECKPOINT_RESTORE is not set/CONFIG_CHECKPOINT_RESTORE=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_FHANDLE is not set
# sed  -i "s/# CONFIG_FHANDLE is not set/CONFIG_FHANDLE=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_UNIX_DIAG is not set
# sed  -i "s/# CONFIG_UNIX_DIAG is not set/CONFIG_UNIX_DIAG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_INET_DIAG is not set
# sed  -i "s/# CONFIG_INET_DIAG is not set/CONFIG_INET_DIAG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_PACKET_DIAG is not set
# sed  -i "s/# CONFIG_PACKET_DIAG is not set/CONFIG_PACKET_DIAG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION
# CONFIG_NETLINK_DIAG is not set
# sed  -i "s/# CONFIG_NETLINK_DIAG is not set/CONFIG_NETLINK_DIAG=y/g" $SLIM_CFG_WORK_PATH/target/linux/generic/config-$KERNEL_VERSION