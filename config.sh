# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c 'import statsmodels.api as sm; sm.show_versions();'
    test_cmd="import sys; import statsmodels; sys.exit(not statsmodels.test('full', extra_argv=['--exe', '--exclude=test_sarimax', '--exclude=test_structural', '--exclude=test_dynamic_factor', '--exclude=test_varmax']).wasSuccessful())"
    python -c "$test_cmd"
}
