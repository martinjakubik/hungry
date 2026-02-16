#!/bin/bash

run_count=0
success_count=0
fail_count=0

test_case="using --when 1 to mean tomorrow"
echo case $test_case
input="-o --when 1"
expected="12:00:00.001 in lobby tomorrow?"
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

test_case="using --when 3 to mean three days"
echo case $test_case
input="-o --when 3"
expected="12:00:00.001 in lobby in 3 days?"
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

test_case="checking invalid --when -3"
echo case $test_case
input="-o --when -3"
expected="usage: $0 --home -h [--days 3|-d 3] --office -o [-w | --what {Burrito, Ravioli, Burger, Pho, Sushi, Sushhhhiiiiiifdidiiiissqihiii}] --badminton -b [--when n]"
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

test_case="checking valid text --when Sh"
echo case $test_case
input="-o --when Sh"
expected="12:00:00.001 in lobby SushiDay?"
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

echo "number of tests:  " $run_count
echo "succeeded:        " $success_count
echo "failed:           " $fail_count
