**Creating a branch**
$ git branch -b "branch-name" will create the new branch and move any current-branch changes that are not already committed to the new branch.

SO you can use that if you start mucking on a branch before you realize you
should do it in a new branch :-)

Then you can push those to github with
$ git push origin "branch name"


**Merging**
(From Andy)
```shell
$ git branch
* "branch-name"
$ git status
$ git commit -am "your message" # if there are uncommitted changes
# Get the local branch updated to github.
$ git push origin "branch-name" # update the remote before merging
# Switch locally to main branch.
$ git checkout main # or "master"
# Merge other branch into main.
$ git merge "branch-name"
$ git commit -am "merging branch-name" # not usually necessary (unless there are conflicts?)
$ git push origin main # update the remote to include the merge
```
