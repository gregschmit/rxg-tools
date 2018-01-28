# Curls

These are fairly simple shell (`sh`) scripts that primarily use `curl` to interact with the rXg's RESTful API.

## Initial Setup

Use `cp` to copy `_init_example` to `_init` and edit the variables inside to match the rXg you want to connect to.

The other scripts are designed to automatically import the environment defined in `_init`.

## Usage

Scripts that begin with "\_" are helpers that generally should only be called from the other scripts.

### Non-Interactive vs Interactive Scripts

The non-interactive version is the "core" script that contains the real functionality and it expects certain parameters to be passed when the script is invoked. The interactive version will end in `_ia`, and it serves as an interactive frontend to the "core" version.

#### Example (non-interactive):

```sh
./command arg1 arg2 arg3
...
```

#### Example (interactive):

```sh
./command_ia
Input arg1: <user input>
Input arg2: <user input>
Input arg3: <user input>
...
```

## Environment

These scripts have the following dependancies:

- `sh` - Bourne shell (or `sh`-compatible)
- `curl`
- `sed` - Stream editor
