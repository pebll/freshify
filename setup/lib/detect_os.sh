#!/usr/bin/env bash

detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    echo "$ID"
  else
    echo "unknown"
  fi
}
