## About this repo
Use this repo to test your understanding of Ancestry References, as described in the Git Book: https://git-scm.com/book/en/v2/Git-Tools-Revision-Selection#_ancestry_references


This repo consists of commits that re-create the structure shown in the diagram by Jon Loeliger at https://git-scm.com/docs/revisions, also copied below:


"Both commit nodes B and C are parents of commit node A. Parent commits are ordered left-to-right."
```
G   H   I   J
 \ /     \ /
  D   E   F
   \  |  / \
    \ | /   |
     \|/    |
      B     C
       \   /
        \ /
         A
```
> [!WARNING]
> The newest commit is on the BOTTOM.


The below chart shows how each parent can be accessed with an ancestor ref from one of the children.
```
A =      = A^0
B = A^   = A^1     = A~1
C =      = A^2
D = A^^  = A^1^1   = A~2
E = B^2  = A^^2
F = B^3  = A^^3
G = A^^^ = A^1^1^1 = A~3
H = D^2  = B^^2    = A^^^2  = A~2^2
I = F^   = B^3^    = A^^3^
J = F^2  = B^3^2   = A^^3^2
```



## try this

Use an ancestor reference and see if it matches what you expect
```bash
git log -1 --format=%s HEAD^
```

Switch to a different commit and try again
```bash
git switch --detach <commit_id>
```

## takeaways
Things are simple with a standard commit:
- `HEAD~` and `HEAD^` do the same thing: they refer to the parent of the current `HEAD`
- Both `HEAD~~` and `HEAD^^` refer to the grandparent
- And so on

Behaviors diverge with a merge commit:
- `HEAD^1` is the same as `HEAD^`: it refers to the first parent.  `HEAD^2` refers to the 2nd parent.  If there's a third parent, you can do `HEAD^3`
- `HEAD~1` is the same as `HEAD~`: it refers to the first parent (same as `HEAD^` or `HEAD^1`).  `HEAD~2` refers to the first parent of the first parent (aka, the first grandparent).  `HEAD~3` refers to the first great-grandparent.

In short: `^` selects **which parent** at a single commit, `~` walks the **first-parent chain**.