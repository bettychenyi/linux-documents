#!/bin/bash

#######################
# bettychen@live.com
#######################

REMOTE=10.0.0.11
USERNAME=betty

echo "create .ssh folder on remote host ..."
ssh $USERNAME@$REMOTE mkdir -p .ssh
echo "copy public key (*.pub) to remote host ..."
cat /home/$USERNAME/.ssh/id_rsa.pub | ssh $USERNAME@$REMOTE 'cat >> .ssh/authorized_keys'
echo "change remote host's .ssh folder permission ..."
ssh $USERNAME@$REMOTE 'chmod 700 .ssh'
echo "change remote host's authorized_keys file permission ..."
ssh $USERNAME@$REMOTE 'chmod 600 .ssh/authorized_keys'
echo "config done."

#test the login with private key.
#remember to exit from the remote host after running this script
echo "testing, login with $USERNAME; please remember to exit."
ssh $USERNAME@$REMOTE
