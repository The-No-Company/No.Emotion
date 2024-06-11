#!/bin/sh

echo "Running tests for iOS code..."
relish verify pre-commit

if [ $? -ne 0 ]; then
  echo "Tests failed."
  exit 1
fi

echo "All checks passed."

