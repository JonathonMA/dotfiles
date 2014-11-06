#!/bin/sh

git branch --merged origin/master | cut -b 3- | xargs -n 1 git branch -d
