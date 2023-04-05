# devops-practical 

#### Release Branch Every 3 Weeks
`.github/workflows/new-branch-every-3-weeks.yml`
[Create Release Branch](https://github.com/riles-m/devops-practical/actions/workflows/new-branch-every-3-weeks.yaml)
In this workflow a new release branch is created every 3 weeks (starting April 4th) from latest commit on the main branch.
#### Tag Release on PR 
`.github/workflows/tag-based-workflow.yml`
[Create Release Tag](https://github.com/riles-m/devops-practical/actions/workflows/tag-based-workflow.yml)
- On merge of PR to main branch the patch version of latest tag is bumped and
  pushed to github.
- It can also be ran manually to create a major or minor release tag from a
  previous tag

*Note*: Semver parsing is done with bash scripts in `.github/scripts` as an example but it would be best to use the community maintained actions in general.

#### Automatically Update Submodule
`.github/workflows/update-submodule.yml`
[Update Submodule](https://github.com/riles-m/devops-practical/actions/workflows/update-submodule.yml)
[submodule repo](https://github.com/riles-m/devops-practical-submodule)
Runs every week and creates a PR that updates submodule *devops-practical-submodule* to the latest commit on it's main branch.
