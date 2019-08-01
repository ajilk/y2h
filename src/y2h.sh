#!/bin/bash

# Data file that needs to be transpiled to HTML
if [ $# -eq 0 ]; then
	echo "usage: ./y2h.sh <datafile>.yaml"
	exit
fi
INPUT_FILE="$1"

html() {
	echo "<!DOCTYPE>"
	echo "<html>"
	element "$1.html.+"
	# echo "$(yq r $INPUT_FILE $1.html.+)"
	echo "</html>"
}

div() {
	echo "<div>"
	element "$1.div.+"
	echo "</div>"
}

p() {
	echo "<p>"
	element "$1.p.+"
	echo "</p>"
}

_txt() {
	echo "$(yq r $INPUT_FILE $1._txt)"
}

a() {
	local href="$(yq r $INPUT_FILE $1.a.href)"
	echo "<a href=$href>"
	element "$1.a.+"
	echo "</a>"
}

_head() {
	echo "<head>"
	element "$1.head.+"
	echo "</head>"
}

title() {
	echo "<title>"
	element "$1.title.+"
	echo "</title>"
}
meta() {
	local charset="$(yq r $INPUT_FILE $1.meta.charset)"
	local name="$(yq r $INPUT_FILE $1.meta.name)"
	local content="$(yq r $INPUT_FILE $1.meta.content)"
	echo "<meta charset=\"$charset\" name=\"$name\" content=\"$content\""
	element "$1.meta.+"
	echo ">"
}

element() {
	local n=0
	until [ "$(yq r $INPUT_FILE $1[$n])" = "null" ]; do
		# get element name
		_TYPE="$(yq r $INPUT_FILE $1[$n] | head -n1 | cut -d ':' -f1)"
		case $_TYPE in
		"html") html "$1[$n]" ;;
		"div") div "$1[$n]" ;;
		"p") p "$1[$n]" ;;
		"_txt") _txt "$1[$n]" ;;
		"a") a "$1[$n]" ;;
		"head") _head "$1[$n]" ;;
		"title") title "$1[$n]" ;;
		"meta") meta "$1[$n]" ;;
		esac
		let n+=1
	done

}

element "main.+"
