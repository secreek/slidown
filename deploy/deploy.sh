#!/bin/bash

error_not_in_repo()
{
	echo "Not in a git repo with remote url."
	exit 101
}

error_not_github()
{
	echo "Repo not hosted on Github."
	exit 102
}

URL=`git config --get-all remote.origin.url`
test -z "$URL" && error_not_in_repo

echo $URL | grep -q github || error_not_github

REPO=`echo $URL | cut -f 2 | cut -d ':' -f 2 | cut -d '/' -f 2 | cut -d '.' -f 1`
USER=`echo $URL | cut -f 2 | cut -d ':' -f 2 | cut -d '/' -f 1`


REMOTE_HOST='mars'
PRODUCT_DIR='/home/'${REPO}'/'${REPO}
GITDIR=${PRODUCT_DIR}'/.git'
ADMIN_SCRIPT=${PRODUCT_DIR}'/deploy/'${REPO}'.sh'
PRODUCT_USER=$REPO
REMOTE_USER='gof'
PARAM='-al'
ssh $REMOTE_HOST "sudo -u $PRODUCT_USER git --git-dir=$GITDIR --work-tree=$PRODUCT_DIR pull ; sudo -u $PRODUCT_USER $ADMIN_SCRIPT restart"

