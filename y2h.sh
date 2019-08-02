#!/bin/bash

# Check file argument and that it exists
if [ $# -eq 0 ]; then
	echo "usage: ./y2h.sh <datafile.yaml>"
	exit
elif [ ! -f $1 ]; then
	echo "$1: File not found!"
	exit
fi

INPUT_FILE="$1"

# Echoes type of the element (void | nonvoid | _txt | etc.)
#
# $1 - Element name
type() {
	local type=""

	case "$1" in
	"_txt") type="_txt" ;;
	"img" | "input" | "hr" | "area" | "link" | "br" | "meta" | "base" | "col" | "embed" | "keygen" | "param" | "source" | "track" | "wbr") type="void" ;;
	*) type="nonvoid" ;;
	esac

	echo $type
}

# Return formatted nonvoid HTML element
#
# $1 - HTML element name (e.g. html, body, div, etc.)
# $2 - path to the HTML element
element() {
	echo -n "<$1 "
	process_attrs "$2.$1.attrs"
	echo ">"
	process "$2.$1.+"
	echo "</$1>"
}

# Return formatted void HTML element
#
# $1 - HTML element name (e.g. img, input, area, etc.)
element_void() {
	echo -n "<$1 "
	process_attrs "$2.$1.attrs"
	echo "/>"
}

# Process element's content accordingly
#
# $1 - element content (specified by <element>.+[*])
process() {
	local i=0
	until [ "$(yq r $INPUT_FILE $1[$i])" = "null" ]; do
		# get process name
		local _ELEMENT="$(yq r $INPUT_FILE $1[$i] | head -n1 | cut -d ':' -f1)"
		local _PATH="$1[$i]"
		local _TYPE=$(type "$_ELEMENT")

		case $_TYPE in
		"void") element_void "$_ELEMENT" "$_PATH" ;;
		"nonvoid") element "$_ELEMENT" "$_PATH" ;;
		"_txt") echo "$(yq r $INPUT_FILE $_PATH.$_ELEMENT)" ;;
		esac
		let i+=1
	done
}

# Process element's attributes
#
# $1 - element attributes (specified by <element>.attr[*])
process_attrs() {
	local i=0
	until [ "$(yq r $INPUT_FILE $1[$i])" = "null" ]; do
		local _ATTR="$(yq r $INPUT_FILE $1[$i] | head -n1 | cut -d ':' -f1)"
		local _VALUE="$(yq r $INPUT_FILE $1[$i].$_ATTR)"
		case "$_ATTR" in
		"_txt") echo -n "$_VALUE" ;;
		*) echo -n "$_ATTR=\"$_VALUE\"" ;;
		esac
		let i+=1
	done
}

# Being process in the main content
process "main.+"
