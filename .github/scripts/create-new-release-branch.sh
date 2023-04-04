#!/bin/bash
git fetch --all
LATEST_RELEASE_BRANCH=$(git branch -a | grep -Eo 'release\/[0-9]*\.[0-9]*\.[0-9]*' | sort --version-sort | tail -n1)
[ -z $LATEST_RELEASE_BRANCH ] && LATEST_RELEASE_BRANCH='0.0.1'
echo The latest release version is \"$LATEST_RELEASE_BRANCH\".  
LATEST_RELEASE_SEMVER=$(echo $LATEST_RELEASE_BRANCH | grep -Eo '[0-9]*\.[0-9]*\.[0-9]*')
echo "semver: $LATEST_RELEASE_SEMVER"
SEM_MAJOR=$(echo $LATEST_RELEASE_SEMVER | awk -F'.' '{print $1}')                             
SEM_MINOR=$(echo $LATEST_RELEASE_SEMVER | awk -F'.' '{print $2}')                             
SEM_PATCH=$(echo $LATEST_RELEASE_SEMVER | awk -F'.' '{print $3}')                             
NEW_RELEASE_BRANCH=$(echo "release/${SEM_MAJOR}.${SEM_MINOR}.$((${SEM_PATCH}+1))")
echo "new release version is $NEW_RELEASE_BRANCH"
git checkout -b "$NEW_RELEASE_BRANCH"
git push origin "$NEW_RELEASE_BRANCH"
