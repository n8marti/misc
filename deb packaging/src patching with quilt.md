General guidelines:
https://packaging.ubuntu.com/html/patches-to-packages.html
https://www.debian.org/doc/manuals/maint-guide/modify.en.html
https://wiki.debian.org/UsingQuilt
Patch headers:
https://dep-team.pages.debian.net/deps/dep3/
Building debian package from python that uses poetry
https://stackoverflow.com/questions/63304163/how-to-create-a-deb-package-for-a-python-project-without-setup-py

```bash
# Create setup.py file with dephell's help.
$ pip3 install wheel dephell
$ dephell deps convert --from-format poetry --from-path pyproject.toml --to-format setuppy --to-path setup.py
# Create the patch file.
$ export QUILT_PATCHES=debian/patches
$ cd ~/src/python3-traffictoll
$ quilt applied
No series file found/No patches applied
$ quilt new 01_build_with_setuppy.diff
Patch debian/patches/01_build_with_setuppy.diff is now on top
$ quilt add pyproject.toml
File pyproject.toml added to patch debian/patches/01_build_with_setuppy.diff
$ sed -i 's/"poetry>=0.12"/"setuptools >= 40.6.0", "wheel"/' pyproject.toml
$ sed -i 's/"poetry.masonry.api"/"setuptools.build_meta"/' pyproject.toml
$ quilt refresh
Refreshed patch debian/patches/01_build_with_setuppy.diff
$ git status # just to see what's new
On branch debify
Your branch is up to date with 'origin/debify'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   debian/rules
	modified:   pyproject.toml

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.pc/
	debian/.debhelper/
	debian/files
	debian/patches/
	debian/python3-traffictoll.debhelper.log
	debian/python3-traffictoll.substvars
	debian/python3-traffictoll/

no changes added to commit (use "git add" and/or "git commit -a")
# Edit the header.
$ quilt header -e 01_build_tool.diff
Replaced header of patch debian/patches/01_build_tool.diff
# Show the updated header.
$ quilt header 01_build_tool.diff
Description: Use setuptools instead of poetry to build the package.
Author: Nate Marti <nate_marti@sil.org>
Last-Update: 2020-09-27
# Undo the local source file changes according to the patch.
$ quilt pop -a
Removing patch debian/patches/01_build_tool.diff
Restoring pyproject.toml

No patches applied
```
