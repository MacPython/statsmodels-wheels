python3.6 -m pip install git+https://github.com/Anaconda-Server/anaconda-client

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

python3.6 ./anaconda.org/rename-wheels.py -d ${TRAVIS_BUILD_DIR}/wheelhouse/

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

if [ "$TRAVIS_BRANCH" == "master" ]; then
    TOKEN=${ANACONDA_TOKEN};
fi

if [ -n "${TOKEN}" ]; then
  anaconda -t ${TOKEN} upload -u statsmodels --force ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl;
fi
