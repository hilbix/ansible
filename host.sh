#!/bin/bash

STDOUT() { local e=$?; printf %q "$1"; [ 1 -ge $# ] || printf ' %q' "${@:2}"; printf \\n; return $e; }
STDERR() { local e=$?; STDOUT "$@" >&2; return $e; }
OOPS() { STDERR OOPS: "$@"; exit 23; }
x() { "$@"; }
o() { x "$@" || OOPS fail $?: "$@"; }
v() { local -n ___var___="$1"; ___var___="$(x "${@:2}")"; }
ov() { o v "$@"; }

ov ME readlink -e -- "$0"
DIR="${ME%/*/*}"

findfile()
{
  local a b
  for a in "${@:2}"
  do
	[ -f "$a" ] && b="$a"
  done
  v "$1" readlink -e -- "$b"
}

createfile()
{
  local PS3="create file: "
  local -A HAVE a b

  for a
  do
	ov b readlink -m "$a"
	test -z "${HAVE["$b"]}" || continue
        HAVE["$b"]="$a"
  done
  select a in "${!HAVE[@]}";
  do
	o touch "$a" && return
  done
}

findorcreate()
{
  while	findfile "$@" && return
	createfile "${@:2}"
  do :; done
  OOPS missing "${@:2}"
}

#U	-v -vv -vvv	be verbose
#U	--step	single step
#U	--syntax-check
#U	-C --check
#U	-D --diff
usage()
{
  printf 'Usage: %q [options] host..\n' "$0"
  sed -n 's/^#U//p' "$0" >&2
  exit 42;
}

findorcreate INV inventory.ini inventory/inventory.ini "$DIR/inventory/inventory.ini" "$DIR/inventory.ini"

OPTION=()
while	case "$1" in
	(-h*|--h*)	usage;;
	(-*)		OPTION+=("$1")
			true;;
	(*)		false;;
	esac
do
	shift
done

for host
do
	case "$host" in
	(*[^a-z0-9.-]*)			OOPS wrong hostname: "$host";;
	(*..*|-*|*-|*-.*|*.-*|-*|*-)	OOPS wrong use of . or - in "$host";;
	esac
	host="${host%.yml}"
	host="${host%.yaml}"
	findorcreate BOOK "$host.yml" "host/$host.yml" "$DIR/host/$host.yml" "$DIR/$host.yml"

	egrep -q -x "^${host//./[.]}($|[[:space:]])" "$INV" || echo "$host" >> "$INV"

	(
	o cd "$DIR/ansible"
	export ANSIBLE_ROLES_PATH="$DIR/roles:$DIR/ansible/roles:$HOME/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles"
	o ansible-playbook "${OPTION[@]}" -i "$INV" "$BOOK"
	) || exit
done

