#!/bin/bash

if [ $# -ne 2 ]; then
	echo "$0 encrypt|decrypt FILE"
	exit 1
fi

action="$1"
filename="$2"

if [ ! -f "$filename" ]; then
	echo "'$filename' does not exist."
	exit 1
fi

if [ "$action" == "decrypt" ] && [ "$filename" != *.gpg ]; then
	echo "'$filename' does not have .gpg extension."
	exit 1
fi

case "$action" in
	encrypt) gpg --symmetric $filename ;;
	decrypt) gpg -o "${filename%.gpg}" --decrypt $filename ;;
	*) echo "Wrong argument"; exit 1 ;;
esac