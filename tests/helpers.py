#!/usr/bin/env python

import subprocess
import traceback
import random
import string
import json
import sys
import os

import pytest

from contextlib2 import contextmanager, ContextDecorator


def for_all_methods(decorator):
    def decorate(cls):
        for attr in cls.__dict__: # there's propably a better way to do this
            if callable(getattr(cls, attr)):
                setattr(cls, attr, decorator(getattr(cls, attr)))
        return cls
    return decorate


def echo(func):
    def echo_func(*func_args, **func_kwargs):
        # print('\nStart func: {}, args: {}, kwargs: {}'.format(func.__name__, func_args, func_kwargs))
        ret_val = func(*func_args, **func_kwargs)
        if ret_val:
            print ret_val
        return ret_val
    return echo_func


class in_run_dir(ContextDecorator):
    def __enter__(self):
        savedPath = os.getcwd()
        if savedPath.endswith('gvgf') or savedPath.endswith('gvgf/tests'):
            try:
                os.chdir('run_dir')
                print "Was in %s, running now in %s" % (savedPath, os.getcwd())
            except BaseException:
                traceback.print_exc()
                sys.exit(1)
        elif 'run_dir' in os.getcwd():
            pass
        else:
            print "Error, unrecognized directory: %s" % savedPath
            sys.exit(1)
        return self

    def __exit__(self, *exc):
        return False

# ============================================================================================================


def random_string():
    return ''.join(random.choice(string.digits) for _ in range(5))


def get_full_semver_expected(branch_name, tag_prefix, commits_made=None, mode="delivery", expected_major_version="0.1.0"):
    if mode == "delivery":
        if not commits_made:
            pass
        pass

    return "%s-%s.%s"
    pass

# ============================================================================================================


@in_run_dir()
@echo
def print_semver_summary():
    try:
        out = subprocess.check_output(['../bash_utils.sh call_gitversion'], shell=True)
        gv_json = json.loads(out)
        print "SemVer: %s" % gv_json["SemVer"]
        print "FullSemVer: %s" % gv_json["FullSemVer"]
        print "MajorMinorPatch: %s" % gv_json["MajorMinorPatch"]
        return gv_json
    except subprocess.CalledProcessError as e:
        print "Exception!"
        print e.output
    except BaseException:
        # traceback.print_exc()
        pass


@in_run_dir()
@echo
def gv(key=None):
    try:
        out = subprocess.check_output(['../bash_utils.sh call_gitversion'], shell=True)
        gv_json = json.loads(out)
        if key:
            return gv_json[key]
        return gv_json
    except subprocess.CalledProcessError as e:
        print "Exception!"
        print e.output
    except BaseException:
        # traceback.print_exc()
        pass


@in_run_dir()
@echo
def get_branch_name():
    branch = subprocess.check_output(['git rev-parse --abbrev-ref HEAD'], shell=True)
    return branch.rstrip()


@in_run_dir()
@echo
def get_branch_name_without_prefix():
    branch = subprocess.check_output(['git rev-parse --abbrev-ref HEAD'], shell=True)
    branch = branch.split('/')
    if len(branch) > 1:
        return branch[1].rstrip()
    return branch[0].rstrip()


@in_run_dir()
@echo
def git_log():
    subprocess.call(['git', 'log'])


@in_run_dir()
@echo
def print_gv():
    print "Calling gitversion:"
    subprocess.call(['gitversion'])


@in_run_dir()
@echo
def create_file(commit=False, ticket_name="ABC-000"):
    filename = random_string() + '.tmp'
    print "Filename: %s" % filename
    open(filename, 'a').close()
    if commit:
        create_commit(ticket_name)
    return filename


@in_run_dir()
@echo
def create_commit(ticket_name="ABC-000", message="Default message"):
    if ticket_name:
        subprocess.call(['git add .'], shell=True)
        subprocess.call([('git commit -m "%s %s"' % (ticket_name, message))], shell=True)


@in_run_dir()
@echo
def create_two_commits(passed_ticket_name):
    create_file(True, passed_ticket_name)
    create_file(True, passed_ticket_name)


@in_run_dir()
@echo
def get_branch_prefix():
    _branch_parts = get_branch_name().split("/")
    print _branch_parts
    if len(_branch_parts) > 1:
        return _branch_parts[0]

    return get_branch_name()


@pytest.fixture(scope="class")
@in_run_dir()
@echo
def reinit_git_script():
    try:
        subprocess.call(['./bash_utils.sh', 'reinit_git'])
    except:
        pass


@in_run_dir()
@echo
def create_empty_commit(message="Initial commit - helpers.py:create_empty_commit()"):
    try:
        subprocess.call(['git commit --allow-empty -m "%s"' % message], shell=True)
    except:
        pass


@pytest.fixture
@in_run_dir()
@echo
def pre_start_branch():
    subprocess.call(['git stash'], shell=True)


@in_run_dir()
@echo
def run(shell):
    try:
        subprocess.call([shell], shell=True)
    except:
        pass

@pytest.fixture(scope="class")
@echo
def delete_git():
    run('rm -rf .git')


@pytest.fixture
@echo
def git_flow_feature_finish():
    run('git flow feature finish')
