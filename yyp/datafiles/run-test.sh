#!/bin/bash
# test.sh

timestamp=$(date +"%Y-%m-%d_%H-%M")
output_file="${timestamp}_run-test.log"
test_files=$(find . -type f -name "*test.json" | sort)
cmd="./visu-project.exe -output \"$output_file\""
for file in $test_files; do
    cmd="$cmd --test \"$file\""
done

echo "$cmd"

eval $cmd
