#!/bin/bash
# sets up usage
USAGE="usage: $0 --home -h --office -o"

# parses and reads command line arguments
while [ $# -gt 0 ]
do
  case "$1" in
    (--home) location="-1";; 
    (-h) location="-1";;
    (--office) location=0;;
    (-o) location=0;;
    (-*) echo >&2 ${USAGE}
    exit 1;;
  esac
  shift
done

if [[ location -eq -1 ]] ; then
  echo Awwwww
elif [[ location -eq 0 ]] ; then
  echo 12:00:00.001 in lobby?
fi
