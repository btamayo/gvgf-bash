#!/usr/bin/env bats

load_lib() {
    local name="$1"
    load "test_helper/${name}/load"
}

load_lib bats-support
load_lib bats-assert
load_lib bats-file

# ----------------------------------------------------------------


@test "addition using bca" {

}

@test "addition using dc" {

}