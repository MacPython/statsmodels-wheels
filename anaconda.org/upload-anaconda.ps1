echo $PWD

echo "Installing anaconda client"
python -m pip install git+https://github.com/Anaconda-Server/anaconda-client.git

echo "Renaming wheels"
python $env:APPVEYOR_BUILD_FOLDER\anaconda.org\rename-wheels.py -d $env:REPO_DIR/dist/

if ($env:BUILD_COMMIT -eq "main"){
    $env:ANACONDA_TOKEN = $env:STATSMODELS_SCIPY_WHEELS_NIGHTLY_TOKEN
    $env:ANACONDA_ORG="scipy-wheels-nightly"
}
else {
    $env:ANACONDA_TOKEN = $env:STATSMODELS_MULTIBUILD_WHEELS_STAGING_TOKEN
    $env:ANACONDA_ORG="multibuild-wheels-staging"
}

if (Test-Path env:ANACONDA_TOKEN) {
    echo "Uploading to anaconda.org account: $env:ANACONDA_ORG"
    anaconda -t $env:ANACONDA_TOKEN upload -u $env:ANACONDA_ORG --force  $env:REPO_DIR/dist/*.whl
} else {
    echo "Not uploading since token not set (expected if this is a pull request)"
}
