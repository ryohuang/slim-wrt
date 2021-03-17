#!/bin/bash

source ./global.sh

echo "Start the build script"

echo $SLIM_PROFILE

load_profile() {
    echo $SLIM_CFG_PROFILE_DIR/profile.sh
    if [ -f $SLIM_CFG_PROFILE_DIR/profile.sh ]
    then
        echo Exist profile. Override some configs now.
        source $SLIM_CFG_PROFILE_DIR/profile.sh
    else
        echo No profile. Override some configs with default values now.
    fi

    SLIM_CFG_WORK_PATH="$SLIM_CFG_TOP_DIR/$SLIM_CFG_PROFILE-src"
    SLIM_CFG_BIN_IMG_DIR="$SLIM_CFG_WORK_PATH/bin/targets/$SLIM_CFG_TARGET/$SLIM_CFG_ARCH"
    SLIM_CFG_PATCHES_MODULES="$SLIM_CFG_TOP_DIR/patches-modules"
    SLIM_CFG_PROFILE_DIR="$SLIM_CFG_TOP_DIR/profiles/$SLIM_CFG_PROFILE"
    cd $SLIM_CFG_TOP_DIR
}



clone_openwrt() {
    # delete download dir for a fresh code base
    if [ -d $SLIM_CFG_DOWNLOAD_PATH/$SLIM_CFG_CLONE_PATH ]
    then
        rm -rf $SLIM_CFG_DOWNLOAD_PATH/$SLIM_CFG_CLONE_PATH
    fi

    if [ ! -d $SLIM_CFG_DOWNLOAD_PATH ]
    then
        mkdir $SLIM_CFG_DOWNLOAD_PATH
    fi

    cd $SLIM_CFG_DOWNLOAD_PATH
    if [ ! -d $SLIM_CFG_CLONE_PATH ]
    then
        git clone  https://github.com/openwrt/openwrt.git  $SLIM_CFG_CLONE_PATH
    fi
    cd $SLIM_CFG_CLONE_PATH
    git checkout $SLIM_CFG_OPENWRT_COMMIT
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    cd $SLIM_CFG_TOP_DIR
}

submodules() {
    cd $SLIM_CFG_TOP_DIR
    git submodule
    git submodule init
    git submodule update
    cd $SLIM_CFG_TOP_DIR
}

create_workspace() {
    if [ ! -d $SLIM_CFG_WORK_PATH ]
    then
        cp -rf $SLIM_CFG_CLONE_PATH $SLIM_CFG_WORK_PATH
    fi
    cd $SLIM_CFG_TOP_DIR
}

list_dirs(){
    echo $1
    cd $1
    j=0
    for i in `ls -d */`
    do
        rp=`realpath $i`
        patch_folder_list[j]=$rp
        j=`expr $j + 1`
    done
    echo ${patch_folder_list[@]}
}

# test it with : bash build.sh clear_patches patch_openwrt
# arg1: The patch's full path.
# Echo true, if found in exclude list
# 
is_excluded_patch() {
    rtn="false"
    if [ -z "$SLIM_CFG_EXCLUDE_PATCH" ]; then
        rtn="false"
    else
        for patch_name in ${SLIM_CFG_EXCLUDE_PATCH[@]}
        do
            full_patch_name=$SLIM_CFG_PATCHES_MODULES/$patch_name
            if [ "$full_patch_name" == "$1" ]
            then
                rtn="true"
                break
            fi
        done  
    fi
    echo $rtn
}

patch_openwrt() {
    patch_folder_list=`list_dirs "$SLIM_CFG_PATCHES_MODULES"`
    echo Patches list : ${patch_folder_list[@]}
    echo Process the patches.

    for i in ${patch_folder_list[@]}
    do
        echo Patch at $i
        retval=`is_excluded_patch "$i"`
        if [ "$retval" == "true" ]
        then
            echo "Exclude patch $i"
            continue
        fi
        if [ -d $i/openwrt ]
        then
            echo Apply patches in $i/openwrt
            cd $SLIM_CFG_WORK_PATH
            git apply $i/openwrt/*.patch
        fi
    done
    cd $SLIM_CFG_TOP_DIR
}

patch_feeds() {
    patch_folder_list=`list_dirs "$SLIM_CFG_PATCHES_MODULES"`
    for i in ${patch_folder_list[@]}
    do
        echo ------ Find feed patch in $i ------
        retval=`is_excluded_patch "$i"`
        if [ "$retval" == "true" ]
        then
            echo "Exclude patch $i"
            continue
        fi
        if [ -d $i/feeds ]
        then
            echo ------ Found feed patch in $i/feeds ------
            feed_folder_list=`list_dirs "$i/feeds"`
            for j in ${feed_folder_list[@]}
            do
                echo ----- feeds patch at $j ------
                if [ "$j" == "$i/feeds" ]
                then
                    echo ------ skip dir . -------
                else
                    echo ------ apply feed patch in $j ------
                    feed_name=${j##*/}
                    feed_in_workspace=$SLIM_CFG_WORK_PATH/feeds/$feed_name
                    cd $feed_in_workspace && git apply $j/*.patch
                fi
            done
        fi
    done
    cd $SLIM_CFG_TOP_DIR
}

do_custom_script() {
    patch_folder_list=`list_dirs "$SLIM_CFG_PATCHES_MODULES"`

    for i in ${patch_folder_list[@]}
    do
        retval=`is_excluded_patch "$i"`
        if [ "$retval" == "true" ]
        then
            echo "Exclude patch $i"
            continue
        fi
        if [ -f $i/custom.sh ]
        then
            cd $i
            source custom.sh
            cd $SLIM_CFG_TOP_DIR
        fi
    done
    cd $SLIM_CFG_TOP_DIR
}

clear_patches() {
    # clear patches in openwrt
    cd $SLIM_CFG_WORK_PATH && git reset --hard ; git clean -df 
    # clear patches in feeds
    feeds_folder_list=`list_dirs "$SLIM_CFG_WORK_PATH/feeds/"`
    for i in ${feeds_folder_list[@]}
    do
        if  [[  "$i"  =~  ".tmp"  ]];then 
            real_feed_dir=${i%.tmp}
            # do the real job.
            cd $real_feed_dir && git reset --hard ; git clean -df 
        fi
    done
    cd $SLIM_CFG_TOP_DIR
}

# do the stuff before showtime
prepare_stage() {
    if [ -f $SLIM_CFG_PROFILE_DIR/config ]
    then
        cp -fr $SLIM_CFG_PROFILE_DIR/config $SLIM_CFG_WORK_PATH/.config
    fi
    cd $SLIM_CFG_WORK_PATH
    rm -f build.log
    make defconfig | tee -a build.log
    make download | tee -a build.log
    if [ -f $SLIM_CFG_PROFILE_DIR/appendconfig ]
    then
        cat $SLIM_CFG_PROFILE_DIR/appendconfig >> $SLIM_CFG_WORK_PATH/.config
    fi
    cd $SLIM_CFG_TOP_DIR
    # Replace ##SLIMVERSIONTAG with current tag or git hash
    # A gittag should be v19.07.7-21030301
    # v: means version
    # 19.07.7: means openwrt branch
    # 210303: means 2021-03-03 (year-mon-day)
    # 01: means release number
    
    # if RELEASE_VERSION starts with "v"
    if [[ $RELEASE_VERSION == v* ]] ;
    then
        sed  -i "s/##SLIMVERSIONTAG/$RELEASE_VERSION/g" $SLIM_CFG_WORK_PATH/.config
    else
        gittag=$( git describe --always )
        sed  -i "s/##SLIMVERSIONTAG/$gittag/g" $SLIM_CFG_WORK_PATH/.config
    fi
    
    cd $SLIM_CFG_TOP_DIR
}


make_it() {
    cd $SLIM_CFG_WORK_PATH
    make -j$(($(nproc)+2)) V=s | tee -a build.log
    cd $SLIM_CFG_TOP_DIR
}

get_pkg_arch_from_config()
{
	config_file_path="$1"
	cat $config_file_path | grep "^CONFIG_TARGET_ARCH_PACKAGES" | sed 's/^.*="\(.*\)"/\1/g'
}

move_built() {
    # move images and related files (version, buildinfo , etc)
    img_dst="$SLIM_CFG_TOP_DIR/images/$SLIM_CFG_PROFILE"
    if [ -d $img_dst ]
    then 
        echo "Clean old images"
        rm -rf $img_dst
    fi
    mkdir -p $img_dst
    # copy .config 
    cp $SLIM_CFG_WORK_PATH/.config $img_dst/full-config
    # list built files
    cd $SLIM_CFG_WORK_PATH/bin/targets/$SLIM_CFG_TARGET/$SLIM_CFG_ARCH
    for i in `ls`
    do
        if [ -f "$i" ]
        then
            cp $i $img_dst
        fi
    done
    # move ipks
    ipk_dst="$SLIM_CFG_TOP_DIR/ipks/$SLIM_CFG_PROFILE"
    if [ -d $ipk_dst ]
    then 
        echo "Clean old images"
        rm -rf $ipk_dst
    fi
    mkdir -p $ipk_dst
    target_arch_packages=$(get_pkg_arch_from_config "$SLIM_CFG_WORK_PATH/.config")
    # x86.slim-src\bin\packages\x86_64\
    cd $SLIM_CFG_WORK_PATH/bin/packages/${target_arch_packages}
    for i in `find . -maxdepth 3 -name "*.ipk"`
    do
        cp -rf $i $ipk_dst
    done
    cd $SLIM_CFG_WORK_PATH/bin/targets/$SLIM_CFG_TARGET/$SLIM_CFG_ARCH
    for i in `find . -maxdepth 3 -name "*.ipk"`
    do
        cp -rf $i $ipk_dst
    done
    cd $SLIM_CFG_TOP_DIR
}

clear_stage() {
    # remove /ipks and /images
    rm -rf $SLIM_CFG_TOP_DIR/ipks
    rm -rf $SLIM_CFG_TOP_DIR/images
    cd $SLIM_CFG_TOP_DIR
}

clear_dist() {
    clear_stage
    rm -rf $SLIM_CFG_TOP_DIR/downloaded
    rm -rf $SLIM_CFG_TOP_DIR/*-src
}

help_msg() {
    cat << EOF
usage: bash build.sh [actions]

actions:
    load_profile: Load profiles. Profiles should defined in /profiles dir.
    clone_openwrt: Clone a fresh openwrt codebase. Codebase controlled by SLIM_CFG_OPENWRT_BRANCH and SLIM_CFG_OPENWRT_COMMIT.
EOF
}

# load_profile
# clone_openwrt
# submodules
# create_workspace
# patch_openwrt
# patch_feeds
# do_custom_script
# prepare_stage
# make_it
# move_built
# clear_patches

load_profile # always load profiles 

for i in "$@"; do
    echo $i
    case $i in
    "clear_stage")
        clear_stage
        ;;
    "clone_openwrt")
        clone_openwrt
        ;;
    "submodules")
        submodules
        ;;
    "create_workspace")
        create_workspace
        ;;
    "patch_openwrt")
        patch_openwrt
        ;;
    "patch_feeds")
        patch_feeds
        ;;
    "do_custom_script")
        do_custom_script
        ;;
    "make_it")
        make_it
        ;;
    "move_built")
        move_built
        ;; 
    "clear_patches")
        clear_patches
        ;; 
    "prepare_stage")
        prepare_stage
        ;; 
    "clear_dist")
        clear_dist
        ;; 
    "help_msg")
        help_msg
        ;; 
    *)
        echo "Unknow command $i"
        help_msg
        exit 1
    esac
done