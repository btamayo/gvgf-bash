import pytest

from pytest_bdd import scenario, given, when, then
import helpers as helpers
from helpers import *

@pytest.mark.incremental
@pytest.mark.usefixtures("delete_git", "reinit_git_script", "pre_start_branch")
class Test_FeatureBranch(object):
    """
    Test git flow start -> commit -> git flow finish basic flow
    """
    sample_ticket_name = 'ABC-%s' % helpers.random_string()

    def get_branch_name(self):
        return "feature/%s" % self.sample_ticket_name

    def test_create_branch_type(self):
        helpers.run('git flow feature start %s' % self.sample_ticket_name)
        assert(helpers.gv("SemVer") == ("0.1.0-%s.1" % self.sample_ticket_name))

    def test_after_two_commits(self):
        """
        Feature branches don't increment per commit.
        :return:
        """
        helpers.create_two_commits(self.sample_ticket_name)
        assert(helpers.gv("SemVer") == ("0.1.0-%s.1" % self.sample_ticket_name))

    def test_after_finish(self):
        helpers.run('git flow feature finish')
        assert(helpers.get_branch_name_without_prefix() == 'master')

        # If we do --no-ff for our merges, it's going to add +1 since we have an extra commit (merge commit)
        assert(helpers.gv("SemVer") == "0.1.0-alpha.3")


@pytest.mark.incremental
@pytest.mark.usefixtures("delete_git", "reinit_git_script", "pre_start_branch")
class Test_ReleaseBranch(object):
    sample_ticket_name = 'ABC-%s' % helpers.random_string()

    def test_create_branch_type(self):
        helpers.run('git flow release start')
        assert(helpers.gv("SemVer") == "0.1.0-rc.1")

    def test_branch_name(self):
        assert("r/%s" % (helpers.gv("MajorMinorPatch")) == helpers.get_branch_name())


@pytest.mark.incremental
@pytest.mark.usefixtures("delete_git", "reinit_git_script", "pre_start_branch")
class Test_StableBranch(object):
    sample_ticket_name = 'ABC-%s' % helpers.random_string()

    def test_check_branch(self):
        helpers.run('git checkout stable')

    def test_stable_gv(self):
        assert(helpers.gv("SemVer") == "0.1.0")


@pytest.mark.incremental
@pytest.mark.usefixtures("delete_git", "reinit_git_script", "pre_start_branch")
class Test_HotfixBranch(object):
    sample_ticket_name = 'ABC-%s' % helpers.random_string()

    def test_check_branch(self):
        helpers.run('git checkout stable')

    def test_stable_gv(self):
        assert(helpers.gv("SemVer") == "0.1.0")
