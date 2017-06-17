import pytest
from gvgf.tests.helpers import * # importing as * imports the fixtures
from test_basic_branch_flow import Test_FeatureBranch
import time


@pytest.mark.incremental
@pytest.mark.usefixtures("delete_git", "reinit_git_script", "pre_start_branch")
class Test_FeatureBranch_Versions_Singular(object):
    """
    One Feature branch at the same
    """
    def test_initial(self):
        branch = Test_FeatureBranch()

        # Create a branch and two commits
        branch.test_create_branch_type()
        branch.test_after_two_commits()

        # Two more commits shouldn't change it
        helpers.create_two_commits(branch.sample_ticket_name)
        assert(helpers.gv("SemVer") == ("0.1.0-%s.1" % branch.sample_ticket_name))

        # Checkout master
        helpers.run('git checkout master')

        # GV should still be the same
        assert(helpers.gv("SemVer") == "0.1.0-alpha.0")

        # Back to feature
        helpers.run('git checkout %s' % branch.get_branch_name())

        # Run git flow feature finish
        helpers.git_flow_feature_finish()

        time.sleep(6) # Allow six seconds

        # Assert master branch
        # Initial commit + Four commits made + 1 merge commit
        assert("master" == helpers.get_branch_name())
        assert(helpers.gv("SemVer") == "0.1.0-alpha.5")
