### GitVersion+GitFlow (GV+GF)

The goal of this project is to integrate [git-flow-hooks]() with  [GitVersion]().

##### What git-flow is:

[https://github.com/petervanderdoes/gitflow-avh](https://github.com/petervanderdoes/gitflow-avh)

Here's a basic introduction to git-flow: 
[https://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/](https://jeffkreeftmeijer.com/2010/why-arent-you-using-git-flow/)

---

**git-flow-hooks**:

**[git-flow-hooks](https://github.com/jaspernbrouwer/git-flow-hooks)** are a set of useful hooks that [do the following](https://github.com/jaspernbrouwer/git-flow-hooks#what-does-it-do):

* Prevent direct commits to the master branch.
* Prevent merge marker commits.
* Automatically bump versions when starting a release or hotfix. 
* Versions are generated, written to file and committed.
* Automatically specify tag messages.

Such that you can do:

```
git flow release start
```  

and

```
git flow bugfix start
```

without having to manually provide a version number.

The way that it determines the version number is the following:

1. Determine the version:
	2. Check if it's passed explicitly:

	```
	git flow release start 1.2.3  # Will use 1.2.3
	```
	
	2. Check if there's a version in the tags.
	3. Check if there's a version-file and read it. The file is named `VERSION`.
		4. If there is no version file, create one and assume the version is 0.0.0.
2. Otherwise, determine the level of the version bump. 
	2. The user can provide the version bump level by passing in the version bump level:
	3. 
	```
	git flow bump minor # Will bump a minor level 0.1.3 -> 0.2.0
	```
	3. Otherwise, the hooks follow the rule:
		4. releases are bumped at a **minor** level: (e.g. 1.2.5 -> 1.3.0)
		5. hotfixes are bumped as a **patch** level: (e.g. 1.2.5 -> 1.2.6)

## GitVersion

GitVersion is a module that automatically calculates a semantic version at any point in time in a specific branch and commit. It uses a combination of tags, commit SHAs and specified user configuration to determine the next version number, which is customizable per-branch. While the details are beyond the scope of this README, more information can be found here: [https://gitversion.readthedocs.io](https://gitversion.readthedocs.io). It's important to node that GitVersion's CLI only determines the calculated semantic version. It does not automatically bump versions, create commits or tags, or modify any files. 

## gvgf

The goal of GVGF is to integrate:

- git-flow's branching model
- git-flow-hooks and automatic version completion, and 
- gitversion's semver calculation

Therefore, the goal is to be able to run

```
git flow release start
```

and invoke git-flow-hooks to read a version from gitversion's calculation, and then proceed with automatically branching and tagging as provided by git-flow.

The advantage of this is to be able to provide an algorithmic, configurable, and flexible semantic versioning while using the robust and extensible branching model of git-flow. It eliminates the need to make a human determination of the "next version number" and instead applies a systematic calculation based on one configuration file.
