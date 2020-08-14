echo $PWD

echo "Installing anaconda client"
python -m pip install git+https://github.com/Anaconda-Server/anaconda-client.git

echo "Renaming wheels"
python $env:APPVEYOR_BUILD_FOLDER\anaconda.org\rename-wheels.py -d $env:REPO_DIR/dist/

if (Test-Path env:ANACONDA_TOKEN) {
    $env:TOKEN = $env:ANACONDA_TOKEN
}

if (Test-Path env:TOKEN) {
    echo "Uploading to anaconda.org"
    anaconda -t $env:ANACONDA_TOKEN upload -u $env:ANACONDA_USERNAME --force  $env:REPO_DIR/dist/*.whl
} else {
    echo "Not uploading since token not set (expected if this is a pull request)"
}
