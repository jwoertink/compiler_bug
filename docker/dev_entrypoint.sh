#!/bin/bash

set -euo pipefail

# This is the entrypoint script used for development docker workflows. By
# default it will:
#  - Install shards.
#  - Run migrations.
#  - Start the dev server.
# It also accepts any commands to be run instead.


warnfail () {
  echo "$@" >&2
  exit 1
}

case ${1:-} in
  "") # If no arguments are provided, start lucky dev server.
    ;;

  *) # If any arguments are provided, execute them instead.
    exec "$@"
esac

if ! [ -d bin ] ; then
  echo "Creating bin directory"
  mkdir bin
fi

if ! shards check ; then
  echo "Installing shards..."
  shards install
fi

echo "Building"
exec crystal build --release src/start_server.cr

echo "Running"
exec ./start_server
