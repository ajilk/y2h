#!/bin/sh

echo > final.tmpl

main() {
	echo "<!DOCTYPE>" >> final.tmpl
	echo "<html>" >> final.tmpl
	echo "<head>" >> final.tmpl
	echo "</head>" >> final.tmpl
	element "div" 
	echo "</html>" >> final.tmpl

}

div() {
	echo "<div>" >> final.tmpl
	# if data.content == h1
	# better: callCorrespondingElement(data.content)
	element "h1" "argument"
	echo "</div>" >> final.tmpl
	# main.content.type
}

h1() {
	echo "<h1>" >> final.tmpl
	echo $1 >> final.tmpl
	echo "</h1>" >> final.tmpl
}

element() {
	if [ $1 == "h1" ]; then
		h1 $2
	elif [ $1 == "div" ]; then
		div $2
	fi
}

main "$@"

cat final.tmpl
