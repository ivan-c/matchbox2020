#!/bin/sh
set -eu

# update matchbox JSON files before start

cp -R /tmp/matchbox /var/lib/matchbox
echo copied matchbox config files
