# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function build_wheel {
    # Prevent spurious numpy upgrade by using bdist_wheel
    build_bdist_wheel $@
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c 'import statsmodels.api as sm; sm.show_versions();'
    pytest --pyargs statsmodels
}