function rename_wheel {
    # Call with a name like numpy-1.19.0.dev0+58dbafa-cp37-cp37m-linux_x86_64.whl

    # Add a date after the dev0+ and before the hash in yyymmddHHMMSS format
    # so pip will pick up the newest build. Try a little to make sure
    # - the first part ends with 'dev0+'
    # - the second part starts with a lower case alphanumeric then a '-'
    # if those conditions are not met, the name will be returned as-is

    newname=$(echo "$1" | sed "s/\(.*dev0+\)\([a-z0-9.]*-.*\)/\1$(date '+%Y%m%d%H%M%S_')\2/")
    echo "$1"
    echo "$newname"
    if [ "$newname" != "$1" ]; then
        mv $1 $newname
    fi
}

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

if [ "$TRAVIS_BRANCH" == "master" ]; then
    TOKEN=${ANACONDA_TOKEN};
    source extra_functions.sh;
    for f in wheelhouse/*.whl; do rename_wheel $f; done;
fi

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

pip install git+https://github.com/Anaconda-Server/anaconda-client;
if [ -n "${TOKEN}" ]; then
  anaconda -t ${TOKEN} upload -u ${ANACONDA_USERNAME} ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl;
fi
