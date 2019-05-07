#!/usr/bin/env bash

terraform-docs markdown table . > README.md

git commit -m $1
git tag $2
git push origin master
git push origin $2
