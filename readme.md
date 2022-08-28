
![python-v3.10.4](https://img.shields.io/badge/python-v3.10.4-D5B942?style=flat-square&logo=replit&labelColor=D5B942&logoColor=3B425A&color=6C9A8B)  
Template for replit. Fork it [here](https://replit.com/@lavneet/Repylat) 🥑 

## Steps to upgrade python to latest version on [replit](https://replit.com/)
-  Find the desired version in NixOS [packages](https://search.nixos.org).
-  Cross-reference the [channel name](https://nixos.wiki/wiki/Nix_channels).
-  Create a python repl based on *any* template. [Default](https://replit.com/@replit/Python) one for instance.
-  Delete **venv** folder.
-  Copy **setup** folder to base of the template.
-  In **.replit** file:  
   - update `channel` under `[nix]` to one that hosts your python package. Note the difference in format (use of `_` instead of `.`)  
   - update `PYTHONPATH` based on new version's expected site-package location.  
   - add `compile = ["sh", "setup/init.sh"]` at the top.  
   - update `run = ["sh", "setup/main.sh"]`
-  In **replit.nix** file:  
   - update `deps` and `PYTHONBIN` with the nix python pkg you love! 
-  Run `python -m venv venv/` to bootstrap virtual environment. It will contain `pip` and other necessary packages.  
     Since virtual env is already added to path in **.replit** file, no need to activate.

#

### Info on python LD_LIBRARY_PATH requirement in NixOS:  
https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats

`PYTHON_LD_LIBRARY_PATH` gets set in **replit.nix**. `setup/main.sh` wrapper script exists so `LD_LIBRARY_PATH` doesn't need to be overridden for the whole repl environment. Doing so, crashes programs like `nix-channel` and many others that rely on default libs.

Most of the [supported](https://replit.com/@replit) replit templates solve this by selectively passing
env var and entrypoint file to interpreter in **.replit** file like so:
```toml
[interpreter]
  [interpreter.command]
  args = [
    "stderred",
    "--",
    "prybar-python3",
    "-q",
    "--ps1",
    "\u0001\u001b[33m\u0002\u0001\u001b[00m\u0002 ",
    "-i",
  ]
  env = { LD_LIBRARY_PATH = "$PYTHON_LD_LIBRARY_PATH" }
```
`stderred` is just to colorize stderr;  
`prybar-python3` handles termination signals (run/stop button) gracefully;

Here **stderred**, which comes pre-installed in replit's default nix environment, works fine when *gcc-10.3.0-lib/lib (path of **pkgs.stdenv.cc.cc.lib** on **stable-21_11** nix channel)  is present in `LD_LIBRARY_PATH`. Sadly, upgrade to python v3.10.4 @**stable-22_05** also updates **pkgs.stdenv.cc.cc.lib** to gcc-11.3.0-lib - rendering it incompatible with programs in replit's default nix environment.

Even if we get rid of stderred, prybar-python3 has only been [compiled](https://github.com/replit/prybar/blob/67f7a00851ab91cd0be5f86002204d46abaa2863/flake.nix#L46) for python3.8 💁‍♂️  
For a more robust approach, instead of using this template, you're welcome to configure replit's [default nix environment](https://docs.replit.com/programming-ide/nix-on-replit).