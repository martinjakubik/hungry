#!/bin/bash

# runs all test files and aggregates results

# initializes counters
total_tests=0
total_success=0
total_failures=0

# array of test files to run
test_files=(
  "test_h_0_base.sh"
  "test_h_1_errors.sh"
  "test_h_2_dates.sh"
  "test_h_3_delays.sh"
)

# runs each test file
for test_file in "${test_files[@]}"; do
  echo "Running $test_file..."
  echo "----------------------------------------"
  # runs the test file and captures the output
  output=$(./$test_file 2>&1)
  echo "$output"
  echo "----------------------------------------"
  echo

  # extracts success and failure counts from the output
  # The format is: "number of tests: X succeeded: Y failed: Z"
  # uses grep to extract these values
  success_count=$(echo "$output" | grep -o "succeeded: *[0-9]*" | cut -w -f 2)
  failure_count=$(echo "$output" | grep -o "failed: *[0-9]*" | cut -w -f 2)
  test_count=$(echo "$output" | grep -o "number of tests: *[0-9]*" | cut -w -f 4)

  # accumulates totals
  total_tests=$((total_tests + test_count))
  total_success=$((total_success + success_count))
  total_failures=$((total_failures + failure_count))
done

# prints aggregated results
echo "========================================"
echo "AGGREGATED RESULTS"
echo "========================================"
echo "Total tests run:    $total_tests"
echo "Total succeeded:    $total_success"
echo "Total failed:       $total_failures"
echo "========================================"

# exits with non-zero status if any failures
if [ $total_failures -gt 0 ] ; then
  exit 1
fi
