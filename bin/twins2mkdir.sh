#!/usr/bin/env bash
# Author: @yudukikun5120
# Web: https://yudukikun5120.me
# License: MIT License

source "$(dirname "$0")/../lib/color.sh"
source "$(dirname "$0")/../lib/separator.sh"

KDB_JSON="$(dirname "$0")/../lib/kdb-parse/kdb.json"

which jq > /dev/null || {
  echo "jq is not installed. Please install jq."
  exit 1
}

check_input()
{
  case "$1" in
    -h|--help)
      echo "Usage: $(basename "$0")"
      echo "Create directories for courses."
      exit 0
      ;;
    *)
      if (( $# > 1 )) ; then
        echo "Usage: $(basename "$0")"
        echo "Try '$(basename "$0") --help' for more information."
        exit 1
      elif (( $# == 1 )) ; then
        csv_path=$(realpath "$1")
      elif (( $# < 1 )) ; then
        read -r -p "Input RSReferCsv.csv path: " csv_path
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
      ;;
  esac
}

make_course_dir()
{
  local course_id="$1"
  local course_name="$2"
  local course_dir="$COURSES_DIR/$course_name"

  if [[ ! -d "$course_dir" ]] ; then
    mkdir "$course_dir"
    echo -e "${GREEN}Created \"$course_name\"$NC"
    (( created_dirs_count++ ))
  elif [[ ! -n "$course_id" ]] ; then
    echo -e "${YELLOW}\"$course_id\" cannot be found.$NC"
  else
    echo -e "${YELLOW}\"$course_name\" already exists.$NC"
    (( skipped_dirs_count++ ))
  fi
}

make_course_dirs()
{
  declare -gi created_dirs_count=0
  declare -gi skipped_dirs_count=0

  while read -r row ; do
    local course_id
    local course_name

    course_id=$(echo "$row" | tr -d '\r\"') 
    course_name=$(< "$KDB_JSON" jq -r .\""$course_id"\"[0])

    make_course_dir "$course_id" "$course_name"
  done < "$1"
}

print_base_dir()
{
  echo -e "Course directories will be created in ${BOLD}$COURSES_DIR${NC} ."
}

print_result()
{
  local -r total_dirs_count=$(( created_dirs_count + skipped_dirs_count ))

  echo -e "${GREEN}Created $created_dirs_count/${total_dirs_count}$NC and \
${YELLOW}skipped $skipped_dirs_count/${total_dirs_count}$NC directories.$NC"
}

check_input "$@"
print_base_dir
make_course_dirs "$csv_path"
horizontal_line
print_result
exit 0
