#!/bin/sh

project=$(basename `pwd`)

setup () {
	sudo pip install virtualenv
	virtualenv --python=python3 .env
	source .env/bin/activate
	pip install pipx
	px setup
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
