#!/bin/bash

run_count=0
success_count=0
fail_count=0

test_case="no arguments"
echo case $test_case
input=""
expected="Meet in lobby at 12:00:00.001?"
actual=$(./h $input 2>&1)
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

test_case="office argument, short"
echo case $test_case
input="-o"
expected="Meet in lobby at 12:00:00.001?"
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

test_case="office argument, long"
echo case $test_case
input="--office"
expected="Meet in lobby at 12:00:00.001?"
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

test_case="home argument, short"
echo case $test_case
input="-h"
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

test_case="home argument, long"
echo case $test_case
input="--home"
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

test_case="badminton argument, short"
echo case $test_case
input="-b"
expected="Awwww 🏸"
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

test_case="badminton argument, long"
echo case $test_case
input="--badminton"
expected="Awwww 🏸"
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

test_case="home argument with 3 days, short;short"
echo case $test_case
input="-h -d 3"
expected="Awwww
One hopes that you feel better soon"
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

test_case="home argument with days, short;long space"
echo case $test_case
input="-h --days 3"
expected="Awwww
One hopes that you feel better soon"
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

test_case="home argument with 5 days, short;long equal"
echo case $test_case
input="-h --days=5"
expected="Awwww
Wow that sounds serious."
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

test_case="home argument with 9 days, short;short"
echo case $test_case
input="-h --days=9"
expected="Awwww
Wow that sounds really serious, wtf. Are you Ok?"
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

test_case="office argument with eat intention, short;short"
echo case $test_case
input="-o -w Burrito"
expected="Meet in lobby at 12:00:00.001? It's Burrrrittooo time!!!"
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

test_case="office argument with eat intention, short;short"
echo case $test_case
input="-o -w Ravioli"
expected="Meet in lobby at 12:00:00.001? It's Raviooooooli time!!!"
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

test_case="office argument with eat intention, short;short"
echo case $test_case
input="-o -w Burger"
expected="Meet in lobby at 12:00:00.001? It's Buuuuuuurger time!!!"
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

test_case="office argument with eat intention, short;short"
echo case $test_case
input="-o -w Pho"
expected="Meet in lobby at 12:00:00.001? It's Phhooooooooo time!!!"
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
