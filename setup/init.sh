#!/bin/sh

ANSI_RGB_ARGS='\e[38;2;'
RED="${ANSI_RGB_ARGS}246;16;103m"
ORANGE="${ANSI_RGB_ARGS}247;176;91m"
GREEN="${ANSI_RGB_ARGS}158;228;147m"
LGREEN="${ANSI_RGB_ARGS}218;247;220m"

# removing latter condition will speed up boot but,
# in my testing pip seem to go awol occasionally.
if [ ! -d venv/ ] || ! venv/bin/pip &> /dev/null; then
  printf "${RED}pip not found${LGREEN}, resetting virtual environment...\n"
  rm -rf venv/
  python -m venv venv/
  printf "${LGREEN}Installing poetry, upm will take over after 🚀\n"
  venv/bin/pip install poetry
  printf "${ORANGE}Ignore the exit status. Hit run again!\n"
  exit 1
fi

# uncomment if you're are a pip
# if [ -f requirements.txt ]; then
#   printf "${LGREEN}Installing dependencies...\n"
#   venv/bin/pip install -r requirements.txt
# fi