## TESTS

The tests for gvgf run in a separate subdirectory.

Before running the tests, a bash script creates the subdirectory `run_dir` if it doesn't exist, clears it, and then symlinks helper bash scripts and config files into the `run_dir` subdirectory.

When running in a CI environment, `setup.cfg` is the setup used.
When running tests in standalone or in development, you can opt to use `tests_branches/pytest.ini` as the config file.
When running using `tox`, you can use `tests_branches/tox.ini` as the config file.
