# cURL Example SDK

These are fairly simple shell (`sh`) scripts that primarily use `curl` to interact with the rXg's RESTful API (and so can be called from any machine with the requisite environment (see below).

I use `xml` rather than `json` because when these are run at the terminal, the `xml` output is more readable without the use of any additional tools.

## Initial Setup

Use `cp` to copy `_init_example.sh` to `_init.sh` and edit the variables inside to match the rXg you want to connect to.

The other scripts are designed to automatically import the environment defined in `_init.sh`.

## Usage

Scripts that begin with "\_" are helpers that generally should be called from other scripts rather than used directly.

### Example:

```sh
./command.sh arg1 arg2 arg3
...
```

## Environment

These scripts rely on a POSIX(ish) environment. They should run on any Unix-like system. They were developed and tested on Ubuntu Linux and OSX/macOS.

### Windows

If you have Windows, you can use:

- [Cygwin](https://cygwin.com), which provides a POSIX environment on Windows
- a hypervisor like [VirtualBox](https://www.virtualbox.org) or [VMware Workstation](https://www.vmware.com/products/workstation-pro.html) -- then install [FreeBSD](https://www.freebsd.org)/[Ubuntu](https://www.ubuntu.com) in a virtual machine

That will likely give you all of the dependencies you need, or at least a package manager that will allow you to fill in the gaps.

### Dependencies:

- `sh` - Bourne shell (or `sh`-compatible)
- `curl`
- `sed` - Stream editor
- `tr`
