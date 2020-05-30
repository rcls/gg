#!/bin/sh

set -e -x

for X in $(git for-each-ref --format='%(refname:short)' refs/heads/*)
do
    git checkout $X
    git rebase master
done

git checkout master
