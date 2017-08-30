#!/bin/sh

project=$(basename `pwd`)

setup () {
}

init () {
	echo "Happy hacking."
}

serve () {
	mkdocs serve -a localhost:3000
}

env () {
	source .env/bin/activate
}

$@
