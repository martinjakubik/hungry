#!/bin/bash

run_count=0
success_count=0
fail_count=0

test_case="office argument with eat intention, mock Friday"
echo case $test_case
input="-o -w Sushhhhiiiiiifdidiiiissqihiii"
expected="Meet in lobby at 12:00:00.001? It's Suuuuuuuushi time!!!"
actual=$(./h --mock_date "2020-01-03" $input 2>&1)
run_count=$(( run_count+1 ))
if [[ ! "$actual" = "$expected" ]] ; then
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

test_case="office argument with eat intention, mock Wednesday"
echo case $test_case
input="-o -w Sushhhhiiiiiifdidiiiissqihiii"
expected="Meet in lobby at 12:00:00.001? Whoa, it's Wednesday!"
actual=$(./h --mock_date "2020-01-01" $input 2>&1)
run_count=$(( run_count+1 ))
if [[ ! "$actual" = "$expected" ]] ; then
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
