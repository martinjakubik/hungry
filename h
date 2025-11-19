#!/bin/bash
# sets up usage
USAGE="usage: $0 --home -h [--days 3|-d 3] --office -o --badminton -b"

location=0
day_count=0

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
    (--days) day_count="$2"; shift;;
    (-d=* | --days=*) day_count="${1#*=}";;
    (-d) day_count="$2"; shift;;
    (-*) echo >&2 ${USAGE}
    exit 1;;
  esac
  shift
done

if [[ location -eq -1 ]] ; then
  echo Awwwww
  if [[ day_count -gt 1 && day_count -lt 5 ]] ; then
    echo One hopes that you feel better soon
  elif [[ day_count -gt 4 && day_count -lt 9 ]] ; then
    echo Wow that sounds serious.
  elif [[ day_count -gt 8 ]] ; then
    echo Wow that sounds really serious, wtf. Are you Ok?
  fi
elif [[ location -eq 1 ]] ; then
  echo Awwwww 🏸
elif [[ location -eq 0 ]] ; then
  echo Meet in lobby at 12:00:00.001?
fi
