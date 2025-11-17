#!/bin/bash
# sets up usage
USAGE="usage: $0 --home -h --office -o --badminton -b"

# parses and reads command line arguments
while [ $# -gt 0 ]
do
  case "$1" in
    (--home) location="-1";; 
    (-h) location="-1";;
    (--office) location=0;;
    (-o) location=0;;
    (--badminton) location=1;;
    (-b) location=1;;
    (-*) echo >&2 ${USAGE}
    exit 1;;
  esac
  shift
done

if [[ location -eq -1 ]] ; then
  echo Awwwww
elif [[ location -eq 1 ]] ; then
  echo Awwwww 🏸
elif [[ location -eq 0 ]] ; then
  echo 12:00:00.001 in lobby?
fi
