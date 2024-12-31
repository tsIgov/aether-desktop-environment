#! /bin/bash
INPUT_FILE="$1"
OUTPUT_FILE="$2"
SASSC_OPT="-M -t compact"

sassc $SASSC_OPT $INPUT_FILE $OUTPUT_FILE
