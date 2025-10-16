TAG=$(poetry version -s)
poetry build

gh release create $TAG --title $TAG --generate-notes
gh release upload $TAG dist/edk-cli-$TAG.tar.gz dist/edk-cli-$TAG-py3-none-any.whl