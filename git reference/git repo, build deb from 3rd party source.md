### Building a debian package from a 3rd party github source.
https://www.atlassian.com/git/tutorials/git-forks-and-upstreams
https://stackoverflow.com/questions/8948803/what-does-git-remote-add-upstream-help-achieve

- Create your own git repo that will be a fork of the upstream repo.
- Clone this repo to your local computer and cd into it.
  ```
  $ git clone https://github.com/wasta-offline/python3-traffictoll
  $ cd python3-traffictoll
  ```
- Identify upstream repo relative to your own repo.
  ```
  $ git remote add upstream https://github.com/cryzed/TrafficToll.git
  ```
- Verify you have "origin" and "upstream" remotes.
  ```
  $ git remote
  origin
  upstream
  ```
- Fetch upstream repo.
  ```
  $ git fetch upstream
  ```
  This seems to get .git/ files but not other project files (?)...
- Switch to "master" branch.
  ```
  $ git checkout master
  ...
  Already on 'master'
  ```
- Rebase your repo's code on the current state of upstream/master.
  ```
  $ git rebase upstream/master
  ...
  No changes -- Patch already applied.
  ```
- Create your own branch on your own repo to potentially send back later as a "pull request", then switch to it.
  ```
  $ git checkout -b debify
  ```
- Make your changes, then commit to your local branch.
  ```
  $ git add [filename] [filename...]
  $ git commit -m "Your commit message"
  ```
- Make sure your local branch is up-to-date with upstream.
  ```
  $ git fetch upstream (?)
  $ git rebase master (or upstream/master? or git rebase -i upstream/master debify?)
  ```
- Publish your own updated branch to your forked repo.
  ```
  $ git push origin debify
  ```
- If you need to incorporate upstream changes, rebase and force push (?).
  ```
  $ git fetch upstream (?)
  $ git rebase master (or upstream/master?)
  $ git push -f origin debify
  ```
