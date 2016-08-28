# Palmetto Cluster Web Page

This repository contains the materials used to build the
website for the Palmetto cluster,
which includes:

1. Palmetto User's Guide
2. Palmetto Software Guide
3. Palmetto Programmer's Guide
4. Palmetto Owner's Guide

This document (`README.md`) details
the organization of files and directories in this repository,
how to make changes to this repository, and
how the website is built from this repository.

## Organization and directory structure

We use [Jekyll](https://jekyllrb.com/) to generate a static website
from [Markdown](https://en.wikipedia.org/wiki/Markdown) files.
The repository is organized as follows:

~~~
.
├── Makefile
├── README.md
├── _config.yml
├── _data/
├── _includes/
│   ├── hardware/
│   ├── owners/
│   ├── programmers/
│   ├── software/
│   └── userguide/
├── _layouts/
├── _site/
├── assets/
├── build.sh
├── deploy.sh
├── directory_structure.txt
├── files/
├── images/
├── index.html
└── pages/
~~~

Most of the content is in the Markdown files (with a `.markdown` extension)
inside the `_includes` directory.
Information about some other important files and directories in this repository
is given below:

~~~
Directory/File   | Description
---------------- + -------------------------------------------------
Makefile         | Makefile
README.md        | This file
_config.yml      | Jekyll configuration file
_data            | Objects defining navigation on all sites
_includes        | Content and common parts to include 
_layouts         | Templates for pages
_site            | Pages generated by Jekyll
assets           | CSS, JS and Fonts used in the template
build.sh         | Script for building the website using Jekyll
deploy.sh        | Script for deploying the website to the web server
files            | Extra files avaliable for download (e.g. PBS documentation, SSH client for Windows)
images           | All images
index.html       | Landing page
pages            | All pages except index.html
---------------- + -------------------------------------------------
~~~

## Making changes

We use [Git](https://git-scm.com/) to manage the source code in this repository.
To get started, you will need to have Git installed and
[configured](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup).
In short, to make a change to this repository,
you need to:

1. check out the latest version of the repository from the remote server to your local machine,
2. make some changes in your local machine, and
3. "push" your changes back to the remote server.

The location of this repository on the remote server is:

~~~
user.palmetto.clemson.edu:/common/hpc/palmetto-website/repo.git
~~~

so, to check out a local copy, you can use `git clone` as follows:

~~~
$ git clone username@user.palmetto.clemson.edu:/common/hpc/palmetto-website/repo.git palmetto-website/
~~~

Note the `username` corresponds to your username on the remote server
`user.palmetto.clemson.edu`.

After making changes to any of the files in `palmetto-website`,
you must commit these changes before pushing them back to the remote server:

~~~
$ git add <file 1> <file 2> ...
~~~

~~~
$ git commit -m "Commit message with summary of changes"
~~~

After committing the change, you can push to the remote server:

~~~
$ git push origin master
~~~

If successful, your changes will be reflected in
the Palmetto cluster website.

Note that you will only need to clone the remote repository once.
To pull in any subsequent changes that anybody else may have
added to the remote repository, use `git pull`:

~~~
$ git pull origin master
~~~

It's a good idea to always `git pull` *before* making any changes
and trying to push them.

### Changing existing sections

The website is organized into several pages,
such as "User's Guide", "Software Guide", "Programmer's Guide", etc.,
each of which is in turn organized into several sections.
The content for these sections is generated from Markdown files,
which are located in the `_includes` directory.
For example, the content for the "Overview of Palmetto" section in the "User's Guide"
is generated from the `includes/userguide/PalmettoOverview.markdown` file.
This is the file you will have to edit to make changes to this section.

### Adding a new section

If you decide to add new section under "User's Guide", "Software Guide"
or "Owner's Guide" you will have to:

a) add a Markdown file with the content to the appropriate directory
under `_includes`, e.g.,
`_includes/userguide` for a new "User's Guide" section,
`_includes/software` for a new "Software Guide" section, or
`_includes/owners` for a new "Owner's Guide" section.

b) add an entry in appropriate file in `_data` directory (either `_data/userguide.yml`,
`_data/software.yml` or `_data/owners.yml`). This entry has to look like this

- id: storage
  path: owners/PurchaseStorage.markdown
  mainTitle: Purchase of Palmetto Storage
  navTitle: Purchase of storage

Where
`id` is a unique key for the section,
`path` is a relative path to the new file that you are adding,
`mainTitle` is the title of the new section that appears in the body of the page, and
`navTitle` is the short title in the navigation panel on the left.

## Deployment

This section provides the details about how
the website is deployed using Git.

The "remote repository" (`user.palmetto.clemson.edu:/common/hpc/palmetto-website/repo.git`)
is a [bare repository](https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server).
The bare repository was initialized with `--shared=group` so that all users
belonging to the `wheel` unix group can push to it. See the documentation for
[git-init](https://git-scm.com/docs/git-init).

This repository is configured with a [Git Hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks),
which is run every time the repository is pushed to by anyone.
Whenever the bare repository is pushed to:

1. A copy of the repository is checked out on the remote server (`user.palmetto.clemson.edu`)
2. From this copy, the website is built, and deployed to the web server (by running `build.sh` and `deploy.sh`).
3. Files in the bare repository that get their group changed to `cuuser` (this happens when `cuusers` push to the repo)
are reset to group `wheel`.

The hook can be found at `user.palmetto.clemson.edu:/common/hpc/palmetto-website/repo.git/hooks/post-receive`.

The checked-out copy of the repository lives right next to the `repo.git` directory.
In principle, the website can be updated by editing the contents of this copy,
and then manually deploying. However, this should **never** be done.
The only place you should ever make changes is on your local copy of the repository,
and the only way these changes should ever be deployed is via a `git push` on your local machine.
