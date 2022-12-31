#!/usr/bin/env bash
# Author: @yudukikun5120
# Web: https://yudukikun5120.me
# License: MIT License

horizontal_line()
{
  local line
  for (( i=0; i<$(tput cols); i++ )) ; do
    line+="-"
  done
  echo "$line"
}

export horizontal_line
