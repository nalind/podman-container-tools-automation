#!/usr/bin/env bash

set -e

TAG=$(date -u +%Y%m%dt%H%M%Sz)

git tag -s -m "$TAG" "$TAG" HEAD
echo "Created tag: $TAG"
echo "Now push this tag upstream to trigger the release automation, if your remote is named upstream use:"
echo "git push upstream $TAG"
