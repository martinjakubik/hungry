#!/bin/bash

run_count=0
success_count=0
fail_count=0

test_case="no arguments"
echo case $test_case
input=""
expected="Meet in lobby at 12:00:00.001?"
actual=$($HOME/code/gitwork/hungry/h "$input")
run_count=$(( run_count+1 ))
if [[ ! $actual = $expected ]] ; then
    fail_count=$(( fail_count+1 ))
    echo failed
    echo "actual:   " "$actual"
    echo "expected: " "$expected"
    echo
else
    echo succeeded
    success_count=$(( success_count+1 ))
    echo
fi


echo "number of tests:  " $run_count
echo "succeeded:        " $success_count
echo "failed:           " $fail_count
