# Introduction

Want to get rid of Ruby RVM and/or have a controlled Python
environment?  These documents tell you how. The Guix solution is
simple and at the same time robust.

Unlike apt, rpm, modules, Brew and Docker, GNU Guix allows you deploy
software in a [reproducible](./REPRODUCIBLE.org) way and have full
control over the dependency graph. You can run multiple versions of
the same software (say Ruby 1.8.7, 2.1.1 and 2.3.0) with their fixated
dependencies and no interference.

The software graph is getting increasingly complex over time. GNU Guix
is the one solution that can handle that complexity. Rather than going
for ad hoc solutions, such as Docker and Brew, we champion using
the right tool for the job.

![alt text](https://github.com/pjotrp/guix-notes/raw/master/python2-virtualenv.png "Dependency graph for python2-virtualenv")

Dependency graph for python2-virtualenv. Notice perl5 is required
because of openssl.

# Useful Guix commands

This is a list of useful Guix commands. The quick path to
installation is using the [binary tarball](https://github.com/pjotrp/guix-notes/blob/master/INSTALL.org#binary-installation).

Add the guix PATH

    export PATH=./guix-profile/bin:$PATH

Start the daemon (normally as root)

    guix-daemon --build-users-group=guixbuild

Update guix itself

    guix package -i guix

List all recommended environment settings

    guix package --search-paths

List all python packages (that contain the word 'python')

    guix package -A python

Install a version of python using a profile

    guix package -p ~/opt/python-2.7.11 -i python@2.7.11

Now you can run this specific version of Python with

    ~/opt/python-2.7.11/bin/python -V

Such profiles can be shared with other users on the system!

Show the contents of a package

    guix package --show=python2-virtualenv

Install Python2 with virtualenv (yes, you can do that)

    guix package -i python2-virtualenv

which installs the binary distribution. If you want to build from
source do

    guix package -i python2-virtualenv --no-substitutes

and if you want to keep the build directories (so to visit them and
see what is happening, especially on error)

    guix package -i python2-virtualenv --no-substitutes -K

Find all dependencies

    guix gc --references /gnu/store/b896978pyr8bfw5bbqv1d7w24163xpxg-python2-virtualenv-13.1.2

Plot a graph of dependencies

    guix package -i graphviz
    guix graph --type=references python2-virtualenv |dot -Gsize="10,10" -Gratio=0.7 -Tsvg -Nfontsize=48 > dag.svg

Rendering the figure above.

Validate the contents of the store against the database (there is also
an option for repair)

    guix gc --verify

List all unused paths (i.e., no longer symlinked) and after remove them

    guix gc --list-dead
    guix gc --collect-garbage

Spawns a shell or container (similar to Docker) where all declared
inputs are available and all environment variables are set

    guix environment --{pure,container} pkg


# Other information

This repository contains Pjotr's notes on working with GNU Guix. I
have gathered [install and 'bootstrapping'
Guix](https://github.com/pjotrp/guix-notes/blob/master/INSTALL.org),
[hacking](https://github.com/pjotrp/guix-notes/blob/master/HACKING.org)
Guix packages with Guile and the philosophy of creating a
[Ruby](https://github.com/pjotrp/guix-notes/blob/master/RUBY.org)
environment and getting rid of RVM, bundler, virtualenv and the like.

You may want to also read [Ricardo's
article](http://elephly.net/posts/2015-04-17-gnu-guix.html) about Guix
on compute clusters and [Malcolm's
guide](https://github.com/malcook/sce/blob/master/README.org).

Enjoy!

Pjotr Prins
