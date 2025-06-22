#!/bin/bash
# echo "`date -Is`: called $@" >>/run/test/ssh_.out
# echo "PASS: $SSHPASS" >>/run/test/ssh_.out

#SSHPASS=12345
sshpass -e ssh "$@"

# SSH_ASKPASS_REQUIRE=force SSH_ASKPASS='./pass.sh' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  "$@"

