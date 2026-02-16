#!/bin/bash

run_count=0
success_count=0
fail_count=0

test_case="bad arguments"
echo case $test_case
input="-x"
expected="usage: ./h_lib.sh --home -h [--days 3|-d 3] --office -o [-w | --what {Burrito, Ravioli, Burger, Pho, Sushi, Sushhhhiiiiiifdidiiiissqihiii}] --badminton -b [--when {Mo, Tu, We, Th, Sh, 1, 2, 3, ...}]"
actual=$(./h $input 2>&1)
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

test_case="incompatible arguments"
echo case $test_case
input="-o -h"
expected="Awwww"
actual=$(./h $input 2>&1)
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
