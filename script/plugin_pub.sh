#!/bin/bash
set -ev

echo "publishing $1"
cd packages/$1
shift;
flutter packages pub publish $@

# if [ "${FLUTTER_CHANGED_PACKAGES}" = "" ] || [ $FLUTTER_CHANGED_GLOBAL -gt 0 ]; then
#   echo "Running for all packages"
#   pub global run flutter_plugin_tools "$@" 
# else
#   echo "Running only for $FLUTTER_CHANGED_PACKAGES"
#   pub global run flutter_plugin_tools "$@" --plugins=$FLUTTER_CHANGED_PACKAGES 
# fi
