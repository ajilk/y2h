#!/bin/sh

OUTPUT_FILE="final.html"

main() {
	echo "<!DOCTYPE>"
	echo "<html>"
	echo "<head>"
	echo "</head>"
	element "div"
	echo "</html>"

}

html() {
	echo "<html>"
	element "head"
	element "body"
	echo "</html>"
}

head() {
	echo "<head>"
	element "meta"
	echo "</head>"
}

body() {
	echo "<body>"
	element "div"
	echo "<body>"
}

meta() {
	echo "<meta >"
}

div() {
	echo "<div>"
	element "h1" "argument"
	echo "</div>"
}

h1() {
	echo "<h1>"
	echo $1
	echo "</h1>"
}

element() {
	case $1 in
	"html") html $2 ;;
	"head") head $2 ;;
	"body") body $2 ;;
	"meta") meta $2 ;;
	"div") div $2 ;;
	"h1") h1 $2 ;;
	esac
}

main "$@"