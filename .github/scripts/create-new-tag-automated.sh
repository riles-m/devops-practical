#!/bin/bash
# finds latest tag and bumps minor version
git fetch --tags                                                                                      
git fetch --prune --unshallow || true                                                                 
LATEST_RELEASE_VERSION=$(git tag -n | awk -F' ' '{print $1}' | sort --version-sort | tail -n1 | tr -d 'v') 
[ -z $LATEST_RELEASE_VERSION ] && export LATEST_RELEASE_VERSION='0.0.1'
echo The latest release version is \"$LATEST_RELEASE_VERSION\".                                       
SEM_MAJOR=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $1}')                             
SEM_MINOR=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $2}')                             
SEM_PATCH=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $3}')                             
NEW_SEMVER_RELEASE=$(echo "${SEM_MAJOR}.${SEM_MINOR}.$((${SEM_PATCH}+1))")
echo The new release version is \"$NEW_SEMVER_RELEASE\".                                              
# Creates new tag and pushes to remote                                                                
git tag "v${NEW_SEMVER_RELEASE}"                                                                      
git push origin "v${NEW_SEMVER_RELEASE}"                                                              
