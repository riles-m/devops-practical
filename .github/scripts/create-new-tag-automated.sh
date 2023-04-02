#!/bin/bash
# finds latest tag and bumps minor version
git fetch --tags                                                                                      
git fetch --prune --unshallow || true                                                                 
export LATEST_RELEASE_VERSION=$(git tag -n | awk -F' ' '{print $1}' | sort --version-sort | tail -n1) 
echo "::set-output name=latest-release::$(echo $LATEST_RELEASE_VERSION)"                              
echo The latest release version is \"$LATEST_RELEASE_VERSION\".                                       
export SEM_MAJOR=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $1}')                             
export SEM_MINOR=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $2}')                             
export SEM_PATCH=$(echo $LATEST_RELEASE_VERSION | awk -F'.' '{print $3}')                             
export NEW_SEMVER_RELEASE$(echo "${SEM_MAJOR}.${SEM_MINOR}.((${SEM_PATCH}+1))")                       
echo "::set-output name=new-release::$(echo $LATEST_RELEASE_VERSION)"                                 
echo The new release version is \"$NEW_SEMVER_RELEASE\".                                              
# Creates new tag and pushes to remote                                                                
git tag "v${NEW_SEMVER_RELEASE}"                                                                      
git push origin "v${NEW_SEMVER_RELEASE}"                                                              
