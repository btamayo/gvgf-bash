#!/usr/bin/env bash


reinit_git() {
	git init
	rm VERSION
	# echo "Running gitversion init"
	# gitversion init
	echo "Running: git flow init"
	git flow init -d
	git checkout -b stable
	git checkout -b master

	git flow config set master stable
	git flow config set develop master
	git flow config set release r/
	git config gitflow.hotfix.finish.message "Hotfix %tag%"
	git config gitflow.release.finish.message "Release %tag%"
	git config --local core.mergeoptions --no-edit
	git config gitflow.path.hooks /Users/btamayo/Development/git-flow-hooks/

	# Since we initialized using default params, wwe need to delete 'develop' which was automatically created
	git branch -D develop

	# Checkout master
	git checkout master
}

delete_git() {
    rm -rf .git
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
