#!/bin/bash

function zl {
  local choice
  choice="$(zipline)"
  if [ -n "$choice" ]; then
      echo "$choice"
      cd "$choice"
  fi
}
