#!/bin/bash

timestamp=$(date +"%Y-%m-%d_%H-%M")
output_file="${timestamp}_run-test.log"
tests=$(find . -type f -name "*test.json" -print0 | xargs -0 echo | sed 's/ /, /g')
cmd="./visu-project.exe -output \"$output_file\" --tests \"$tests\""

eval $cmd
