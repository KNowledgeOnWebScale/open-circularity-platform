#!/bin/bash
# Set permissions on all demo contents

# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status
set -euo pipefail

echo "$0 started."
./set_perms_construction.sh
./set_perms_textile.sh
echo "$0 done."

# satisfy the health check and stay alive
touch /healthy.flag
sleep infinity
