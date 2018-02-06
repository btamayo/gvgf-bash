#!/usr/bin/env bash

run_python() {
	fn_name="$1"
	python -c 'from helpers.py import ${fn_name}; ${fn_name}()'
}

reinit_git() {
	git init
	rm VERSION || true
	# echo "Running gitversion init"
	# gitversion init

	sleep 2

	echo "Running: git flow init"
	git flow init -d

	sleep 2

	git checkout -b stable
	git checkout master

	git flow config set master stable
	git flow config set develop master
	git flow config set release r/


	sleep 2
	
	git config gitflow.hotfix.finish.message "Hotfix %tag%"
	git config gitflow.release.finish.message "Release %tag%"
	git config --local core.mergeoptions --no-edit
	git config gitflow.path.hooks /Users/btamayo/gvgf-bash/git-flow-hooks-bt/  #TODO change to not be hardcoded

	# Since we initialized using default params, wwe need to delete 'develop' which was automatically created
	# git branch -D develop
	
	# Checkout master
	git checkout master
}

delete_git() {
    rm -rf .git || true
}

initial_commit() {
	git checkout master
	git commit --allow-empty -m "Initial commit - from bash_utils.sh"
}

call_gitversion() {
    gitversion
}

# Clashes hotfix and feature branch 
clash_hotfix() {
	gffs ABC-001-hotfixclash
	gv
	git checkout master
	gv
	git checkout stable
	gv
	git flow hotfix start
	gv
}

"$@"
