#!/bin/bash

# Data file that needs to be transpiled to HTML
INPUT_FILE="index.yaml"

html() {
	echo "<!DOCTYPE>"
	echo "<html>"
	element "$1"
	echo "</html>"
}

head() {
	echo "<head>"
	element "$1"
	echo "</head>"
}

title() {
	echo "<title>"
	echo "`yq r $INPUT_FILE $1`"
	echo "</title>"
}

meta() {
	echo "<meta"
	element "$1"
	echo ">"
}

body() {
	echo "<body>"
	element "$1"
	echo "</body>"
}

div() {
	echo "<div>"
	element "$1"
	echo "</div>"
}

h1() {
	echo "<h1>"
	echo "`yq r $INPUT_FILE $1`"
	echo "</h1>"
}

multiple() {
	local n=0
	until [ "$(yq r $INPUT_FILE $1[$n])" = "null" ]; do
		element "$1[$n].element"
		let n+=1
	done
}

element() {
	_TYPE=$(yq r $INPUT_FILE $1.type)

	case $_TYPE in
	"html") html "$1.content.element" ;;
	"multiple") multiple "$1.content" ;;
	"head") head "$1.content.element" ;;
	"title") title "$1.content" ;;
	"meta") meta "$1.content.element" ;;
	"body") body "$1.content.element" ;;
	"div") div "$1.content.element" ;;
	"h1") h1 "$1.content" ;;
	esac
}

element "element"
