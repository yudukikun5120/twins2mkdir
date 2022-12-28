#!/usr/bin/env bash
# Author: @yudukikun5120
# Web: https://yudukikun5120.me
# License: MIT License

source color.sh

COURSES_DIR="$HOME/Library/CloudStorage/OneDrive-筑波大学"
KDB_JSON="kdb-parse/kdb.json"

which jq > /dev/null || {
  echo "jq is not installed. Please install jq."
  exit 1
}

if [[ $1 == "-h" || $1 == "--help" ]] ; then
  echo "Usage: $(basename "$0")"
  echo "Create directories for courses."
  exit 0
elif [[ ! $# -eq 1 ]] ; then
  echo "Usage: $(basename "$0")"
  echo "Try '$(basename "$0") --help' for more information."
  exit 1
elif [[ ! -f $1 ]] ; then
  echo "Error: $1 is not a file."
  exit 1
elif [[ ! $(basename "$1") == "RSReferCsv.csv" ]] ; then
  echo "Error: $1 is not RSReferCsv.csv."
  exit 1
elif [[ ! -d "$COURSES_DIR" ]] ; then
  echo "Error: $COURSES_DIR does not exist."
  exit 1
elif [[ ! -f "$KDB_JSON" ]] ; then
  echo "Error: $KDB_JSON does not exist."
  exit 1
fi

while read -r row ; do
  course_id=$(echo "$row" | tr -d '\r\"') 
  course_name=$(< "$KDB_JSON" jq -r .\""$course_id"\"[0])
  course_dir="$COURSES_DIR/$course_name"
  [ ! -d "$course_dir" ] && mkdir "$course_dir" &&
  echo -e "${GREEN}Created $course_dir$NC" ||
  echo -e "$course_dir already exists."
done < "$1"

exit 0
