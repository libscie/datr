# Resubmission

This is a resubmission based on comments from March 7. I fixed:

* No longer start package with "This package" or similar
* Single quotes for software and packages in DESCRIPTION
* Add more examples in documentation
* Removed writes by default. All functions that write to local machine now require user to specify dir/path.
First submission after a long time of lurking. Hi! 👋 

# Test environments

* Fedora 27, R 3.4.3
* x86_64-w64-mingw32 (64-bit), R Under development (unstable) (2018-03-06 r74362)

# R CMD CHECK results

── 0 errors ✔ | 0 warnings ✔ | 0 notes ✔

# Downstream dependencies 

No issues when running `devtools::revdep_check()`.