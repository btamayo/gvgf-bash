#!/usr/bin/env bats

load_lib() {
    local name="$1"
    load "test_helper/${name}/load"
}

load_lib bats-support
load_lib bats-assert
load_lib bats-file

# ----------------------------------------------------------------

setup() {
	./init_run.sh
	./bash_utils.sh reinit_git
	cd run_dir
}

@test "addition using bca" {

}

@test "addition using dc" {

}