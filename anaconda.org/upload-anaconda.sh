if [[ ${TRAVIS_OS_NAME} = "linux" ]]; then
  # Ensure working Python 3.6 on Linux
  sudo apt-get -y install software-properties-common
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt-get update
  sudo apt-get -y install python3.6 python3.6-dev
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python3.6 get-pip.py
  sudo ln -s /usr/bin/python3.6 /usr/local/bin/python3
fi

echo "Installing anaconda client"
python3 -m pip install git+https://github.com/Anaconda-Server/anaconda-client

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

echo "Renaming wheels"
python3 ./anaconda.org/rename-wheels.py -d ${TRAVIS_BUILD_DIR}/wheelhouse/

ls ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl

if [ "$TRAVIS_BRANCH" == "master" ]; then
    TOKEN=${ANACONDA_TOKEN};
fi

if [ -n "${TOKEN}" ]; then
  echo "Uploading to anaconda.org"
  anaconda -t ${TOKEN} upload -u ${ANACONDA_USERNAME} --force ${TRAVIS_BUILD_DIR}/wheelhouse/*.whl;
else
  echo "Not uploading since token not set (expected if this is a pull request)"
fi
