#!/bin/bash

set -e

timestamp=$(date +%Y-%m-%d-%H%M%S)
branch_name="stash/$timestamp"

echo -n "Stashing dirty files to $branch_name ..."
cd "$(dirname "$(git rev-parse --git-dir)")"
git checkout -qb "$branch_name"
git add --all .
git commit -qm "STASH"
git checkout -q -
echo "done."
