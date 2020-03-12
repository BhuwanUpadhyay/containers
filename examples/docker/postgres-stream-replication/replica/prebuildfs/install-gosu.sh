#!/bin/bash

set -e

VERSION="1.11"

curl --silent -L "https://github.com/tianon/gosu/releases/download/${VERSION}/gosu-amd64" > "/usr/local/bin/gosu"
chmod u+x "/usr/local/bin/gosu"