#!/bin/bash

# Check file argument and that it exists
if [ $# -eq 0 ]; then
	echo "usage: ./y2h.sh <datafile>.yaml"
	exit
elif [ ! -f $1 ]; then
	echo "$1: File not found!"
	exit
fi
INPUT_FILE="$1"

# Echoes "void" if element is a void element
#
# $1 - element name
type() {
	local type=""
	case "$1" in
	"_txt") type="_txt" ;;
	"img" | "input" | "hr" | "area" | "link" | "br" | "meta" | "base" | "col" | "embed" | "keygen" | "param" | "source" | "track" | "wbr") type="void" ;;
	*) type="nonvoid" ;;
	esac

	echo $type
}

# Return formatted HTML element
#
# $1 - HTML element (e.g. html, body, div, etc.)
# $2 - path to the HTML element
element() {
	echo -n "<$1 "
	# process element arguments
	process_args "$2.$1.args"
	echo ">"
	# process element content
	process "$2.$1.+"
	echo "</$1>"
}

element_void() {
	echo -n "<$1 "
	process_args "$2.$1.args"
	echo "/>"
}

process() {
	local n=0
	until [ "$(yq r $INPUT_FILE $1[$n])" = "null" ]; do
		# get process name
		local _ELEMENT="$(yq r $INPUT_FILE $1[$n] | head -n1 | cut -d ':' -f1)"
		local _PATH="$1[$n]"
		local _TYPE=$(type "$_ELEMENT")

		case $_TYPE in
		"void") element_void "$_ELEMENT" "$_PATH" ;;
		"nonvoid") element "$_ELEMENT" "$_PATH" ;;
		"_txt") echo "$(yq r $INPUT_FILE $_PATH.$_ELEMENT)" ;;
		esac
		let n+=1
	done
}

process_args() {
	local n=0
	until [ "$(yq r $INPUT_FILE $1[$n])" = "null" ]; do
		local _ARG="$(yq r $INPUT_FILE $1[$n] | head -n1 | cut -d ':' -f1)"
		local _CONTENT="$(yq r $INPUT_FILE $1[$n].$_ARG)"
		echo -n "$_ARG=\"$_CONTENT\""
		let n+=1
	done
}

debug() {
	printf "%b" "\e[1;31m$1\e[0m"
}

process "main.+"