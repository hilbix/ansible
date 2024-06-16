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
  ov "$1" readlink -e -- "$b"
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

findfile INV "$DIR/inventory.ini" inventory.ini

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
	findfile BOOK "$DIR/$host.yaml" "$DIR/$host.yml" "$host.yaml" "$host.yml"

	egrep -q -x "^${host//./[.]}($|[[:space:]])" "$INV" || echo "$host" >> "$INV"

	(
	o cd "$DIR/ansible"
	export ANSIBLE_ROLES_PATH="$DIR/roles:$DIR/ansible/roles:$HOME/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles"
	o ansible-playbook "${OPTION[@]}" -i "$INV" "$BOOK"
	) || exit
done

