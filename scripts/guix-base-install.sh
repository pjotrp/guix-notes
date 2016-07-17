#!/bin/bash
#
# Basic packages

set -e

PKGS="screen vim emacs"

echo $PKGS

for pkg in $PKGS ; do 
  guix package -i $pkg
done

