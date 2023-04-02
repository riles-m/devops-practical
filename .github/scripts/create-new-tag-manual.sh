#!/bin/bash
# Takes tag input and type of release and bumps
export TAG=$(echo ${{ inputs.tag }} | tr -d 'v')
export SEM_MAJOR=$(echo $TAG | awk -F'.' '{print $1}')
export SEM_MINOR=$(echo $TAG | awk -F'.' '{print $2}')
export SEM_PATCH=$(echo $TAG | awk -F'.' '{print $3}')
if ${{ inputs.release_type }} = "major"; then
  export NEW_SEMVER_RELEASE$(echo "((${SEM_MAJOR}+1)).${SEM_MINOR}.${SEM_PATCH}")
elif ${{ inputs.release_type }} = "minor"; then
  export NEW_SEMVER_RELEASE$(echo "${SEM_MAJOR}.((${SEM_MINOR}+1)).${SEM_PATCH}")
elif ${{ inputs.release_type }} = "patch"; then
  export NEW_SEMVER_RELEASE$(echo "${SEM_MAJOR}.${SEM_MINOR}.((${SEM_PATCH}+1))")
fi
echo The new release version is \"$NEW_SEMVER_RELEASE\".
# Creates new tag and pushes to origin
git tag "v${NEW_SEMVER_RELEASE}"
git push origin "v${NEW_SEMVER_RELEASE}"
