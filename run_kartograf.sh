#!/bin/bash
read -p "Enter timestamp (press enter for current time): " timestamp

if [ -z "$timestamp" ]; then
  nix develop --command bash -c "kartograf map"
else
  nix develop --command bash -c "kartograf map -w $timestamp"
fi
