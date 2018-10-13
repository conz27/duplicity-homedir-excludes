#!/bin/bash

BASE=./rsync-homedir-excludes/rsync-homedir-excludes.txt
DUPLICITY_EXCLUDE_LIST=duplicity-homedir-excludes.txt
INSTALL_DIR=$HOME/.duplicity

if [ ! -e "$BASE" ]; then
    echo ERROR: could not find $BASE
    exit 1
fi

cat << __EOF__ > $DUPLICITY_EXCLUDE_LIST
###################################################################################################
# dupliclity-homedir-excludes
#
# A list of files to exclude when backing up *nix home directories using duplicity.
#
#       Author: Constantine Grantcharov <https://github.com/conz27/duplicity-homedir-excludes.git>
#       Version: $(date)
#
# This script was inspired by Ruben Barkow <https://github.com/rubo77/rsync-homedir-excludes>
#
###################################################################################################

__EOF__

sed -e '1,12d' $BASE >> $DUPLICITY_EXCLUDE_LIST


sed -i -E "s|^#([A-Za-z\.\*])|#-\ $HOME/\1|g" $DUPLICITY_EXCLUDE_LIST
sed -i -E "s|^([A-Za-z\.\*])|-\ $HOME/\1|g" $DUPLICITY_EXCLUDE_LIST

# Special Handling for directories that start with '/'
sed -i -E "s|^#([/])|#-\ $HOME\1|g" $DUPLICITY_EXCLUDE_LIST
sed -i -E "s|^([/])|-\ $HOME\1|g" $DUPLICITY_EXCLUDE_LIST

mkdir -p $INSTALL_DIR
cp -i $DUPLICITY_EXCLUDE_LIST $INSTALL_DIR
