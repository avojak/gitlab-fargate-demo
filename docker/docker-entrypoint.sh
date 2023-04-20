#!/bin/sh

USER_SSH_KEYS_FOLDER=~/.ssh
[ ! -d ${USER_SSH_KEYS_FOLDER} ] && mkdir -p ${USER_SSH_KEYS_FOLDER}

echo ${SSH_PUBLIC_KEY} > ${USER_SSH_KEYS_FOLDER}/authorized_keys

unset SSH_PUBLIC_KEY

exec /usr/sbin/sshd -D