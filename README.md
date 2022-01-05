# `statsmodels-wheels`

## Building and uploading statsmodels wheels

We automate wheel building using this custom github repository that
builds Linux, macOS and Windows wheels using GitHub actions.

The GitHub actions for the builds is
<https://github.com/MacPython/statsmodels-wheels/actions>

The driving Github repository is
<https://github.com/MacPython/statsmodels-wheels>

## Using the repository

The repository contains the branches:

- `main` - for development and daily builds;
- `rel-x.y.z` - for building releases.

GitHub actions builds the `main` regularly (daily/weekly) via cron jobs.

Builds from the `main` branch uploaded [Anaconda.org](https://anaconda.org/scipy-wheels-nightly/statsmodels).

Builds from the release branches upload to an
[Anaconda.org staging repository](https://anaconda.org/multibuild-wheels-staging/statsmodels).

Pull requests should usually be submitted to the `main` branch.

## How it works

The wheel builder relies on [cibuildwheel](https://github.com/pypa/cibuildwheel).

### NEVER UPLOAD AN API KEY

Keys for uploading are stored as secrets and not part of the repository.

## Triggering a build

You will likely want to edit `build_wheels.yml` to specify the `BUILD_COMMIT`
before triggering a build - see below.

You will need write permission to the Github repository to trigger new
builds on the Travis-CI interface. Contact us on the mailing list if you
need this.

You can trigger a build by:

- making a commit to the `statsmodels-wheels` repository (e.g. with
  `git commit --allow-empty`); or
- clicking on the circular arrow icon towards the top right of the
  Travis-CI page, to rerun the previous build.

In general, it is better to trigger a build with a commit, because this
makes a new set of build products and logs, keeping the old ones for
reference. Keeping the old build logs helps us keep track of previous
problems and successful builds.

### Which statsmodels commit does the repository build?

The `statsmodels-wheels` repository will build the commit specified in
the `BUILD_COMMIT` at the top of the `build_wheels.yml` and `appveyor.yml`
files. This can be any naming of a commit, including branch name, tag
name or commit hash.

## Uploading the built wheels to PyPI

- pre-releases container visible at
  <https://anaconda.org/scipy-wheels-nightly/statsmodels>
- release container visible at
  <https://anaconda.org/multibuild-wheels-staging/statsmodels>

When the wheels are updated, you can download them to your machine
manually, and then upload them manually to PyPI, or by using
[twine](https://pypi.python.org/pypi/twine).

You will need permissions to upload to PyPI to upload the wheels.
