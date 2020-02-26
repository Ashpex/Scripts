#!/usr/bin/env bash
hugoDir=/home/ashpex/Downloads/codeberg/hugo
webDir=/home/ashpex/Downloads/codeberg/blog
cd $hugoDir
hugo
echo "================================="
echo "Generating hugo site"
git add -A
echo -e "Enter comment: "
read comment
git commit -m "$comment"
git push
echo "================================="
echo "Committed successfully"
