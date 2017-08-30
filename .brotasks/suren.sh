#!/bin/sh

project=$(basename `pwd`)

init () {
	structure $project
		window editor
			run "bro env"
			run "vim"
		window stuff
			vsplit
				run "bro env"
				run "bro serve"
			pane right
				run "bro env"
		window terminal
			run "bro env"
	connect $project
	focus "editor"
}

$@
