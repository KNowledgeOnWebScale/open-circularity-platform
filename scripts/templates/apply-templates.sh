#!/bin/bash
# Execute this file in the parent directory of where to apply the templates (usually the project root).
# Make sure environment variables were set!
#
# Inspired by https://www.baeldung.com/linux/nginx-config-environment-variables

# in case of project root, make sure to ignore node_modules (needs -prune and -print!)
find . -path ./node_modules -prune -o -name '*.template' -print | while read f ; do
  FOUT=${f%.template}
  echo "$f --> $FOUT"
  envsubst < $f > $FOUT
  if [[ "${FOUT##*.}" == "sh" ]] ; then
    chmod +x $FOUT
  fi
done
