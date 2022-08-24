#!/bin/sh

# https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats
export LD_LIBRARY_PATH="$PYTHON_LD_LIBRARY_PATH"
python main.py