#!/bin/bash

HOST=storage.example.com
IDENTITY_FILE=${IDENTITY_FILE:-$HOME/.ssh/id_rsa}
REMOTE_DIR=backups
RSYNC_URL=rsync://$USER@$HOST/$REMOTE_DIR

mkdir -p $HOME/.duplicity

duplicity full \
    --verbosity info \
    --log-file $HOME/.duplicity/info.log \
    --exclude-filelist $HOME/.duplicity/duplicity-homedir-excludes.txt \
    --ssh-options="-o IdentityFile=${IDENTITY_FILE}" \
    --asynchronous-upload \
    $HOME \
    $RSYNC_URL
