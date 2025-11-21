#!/bin/bash
current_date=$(date -I)

if [[ "$1" = "--mock_date" ]] ; then
  shift;
  current_date=$1; shift;
fi
h_lib.sh "$current_date" "$@"