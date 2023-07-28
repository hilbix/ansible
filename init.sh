#!/bin/bash
# vim: ft=bash
#
# Init some new host.
#
# Usage: ./init.sh ssh-connection

TARGET=git/ansible

DEST="${1:?Give destinatin as first argument}"

STDOUT() { printf %q "$1"; printf ' %q' "${@:2}"; printf '\n'; }
STDERR() { local e=$?; STDOUT "$@" >&2; return $e; }
OOPS() { STDERR OOPS: "$@"; exit 23; }
v() { local -n __var__="$1"; __var__="${@:2}"; }
x() { "$@"; STDERR exec $?: "$@"; }
o() { "$@" || OOPS fail $?: "$@"; }
ov() { local -n __var__="$1"; __var__="$("${@:2}")" || OOPS fail $?: set "$1" to "${@:2}"; }
i() { "$@" 2>/dev/null; }
w() { "${@:2}" >"$1"; }

o cd "$(o dirname -- "$0")"

play()
{
  o ansible-playbook -v -i "$DEST," -e "ansible_user=$U" "$@"
}

# https://superuser.com/a/1784378/72223
# SSH dest 'script' args..
SSH()
{
  local ARGS;
  printf -v ARGS ' %q' "$2" -- "${@:3}" &&
  ssh "$1" -- "/bin/bash --noprofile --norc -c -- $ARGS";
}

ov st git status --porcelain
[ -z "$st" ] || STDERR "$st" || OOPS git status not clean

o play init/wait.yml

# Transfer our SSH credentials
o ssh-copy-id "$DEST"

# Setup sudo
# Do it a way which also works for older local ansible variants
x SSH "$DEST" 'sudo -n true' ||
{
# Try to setup sudo via sudo
x SSH "$DEST" 'which sudo' && x play init/sudo-sudo.yml -K
# Setup sudo via su if previous failed
x SSH "$DEST" 'sudo -n true'  || o play init/sudo-su.yml -K
}

# Install ansible
# We need to do this here, because our local ansible may be too old
o play init/ansible.yml

# Create or update copy of this installation
x SSH "$DEST" 'git init "$1"' "$TARGET"
o git push --force "$DEST":"$TARGET"/.git HEAD:master-tmp
o SSH "$DEST" 'cd "$1" && s="`git status --porcelain`" && [ -z "$s" ] && git checkout -B master master-tmp && s="`git status --porcelain`" && [ -z "$s" ]' "$TARGET"

# Initialize the whole basic environment
# and setup all the standard packages
o SSH "$DEST" 'ansible-playbook -i "$1"/inventory/localhost "$1"/init/init.yml' "$TARGET"

# Now create the local host branch if missing
ov fqdn SSH "$DEST" 'hostname -f'

fqdn="${fqdn,,}"
o test -n "$fqdn"

BRANCH="host/$fqdn"
[ ".$fqdn" = ".$DEST" ] || STDERR Note: using branch "$BRANCH" from FQDN instead of destination "$DEST"

x git rev-parse -q --verify "$BRANCH" >/dev/null || o git branch "$BRANCH" empty

# If this fails due to ./.git/modules/host/ exists,
# something weird happened and you need to resolve yourself.
[ -e "$BRANCH/.git" ] || o git clone -b empty ./ "$BRANCH"

# We cannot use 'git submodule' directly,
# because I found no way to force `git submodule` from staying local.
# As it this tries to pull from the tracked remote,
# the branch does not yet exist there, so the command must fail.
x i git submodule status "$BRANCH" >/dev/null || o git submodule add -b "$BRANCH" ./ "$BRANCH"

# make sure it really is checked out
o test -d "$BRANCH"
o test -e "$BRANCH/.git"

YML="$BRANCH/playbooks/$fqdn.yml"

if	[ ! -s "$YML" ]
then
        o mkdir -p "${YML%/*}"
        o w "$YML" cat <<EOF
---
- import_playbook: dist-upgrade.yml

EOF
  o git -C "$BRANCH" add "playbooks/$fqdn.yml"
  o git -C "$BRANCH" commit -m 'automatic commit'
  o git add "$BRANCH"
fi

exec ./push.sh "$DEST"

