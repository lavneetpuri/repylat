#!/bin/sh

if [ ! -d venv/ ] || ! venv/bin/pip > /dev/null; then
  echo "pip not found, resetting virtual environment..."
  rm -rf venv/
  python -m venv venv/
fi

if [ ! -d requirements.txt ]; then
  echo "Installing dependencies..."
  venv/bin/pip install -r requirements.txt
fi