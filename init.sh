#!/bin/bash

# This script was used to create the commits for this repo

set -e

git init

# A is a parent of B & C (merge commit)
# G   H   I   J
#  \ /     \ /
#   D   E   F
#    \  |  / \
#     \ | /   |
#      \|/    |
#       B     C
#        \   /
#         \ /
#          A  <-- HEAD

T=$(git mktree < /dev/null)

G=$(git commit-tree $T -m "G")
H=$(git commit-tree $T -m "H")
I=$(git commit-tree $T -m "I")
J=$(git commit-tree $T -m "J")
E=$(git commit-tree $T -m "E")

D=$(git commit-tree $T -p $G -p $H -m "D")
F=$(git commit-tree $T -p $I -p $J -m "F")

B=$(git commit-tree $T -p $D -p $E -p $F -m "B")
C=$(git commit-tree $T -p $F -m "C")

A=$(git commit-tree $T -p $B -p $C -m "A")

git branch -f main $A
git checkout main

git log --oneline --graph --all