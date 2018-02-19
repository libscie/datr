[![datr logo](assets/datr-data-logo.svg.png)](https://github.com/datproject/design)

[![Build Status](https://travis-ci.org/libscie/datr.svg?branch=master)](https://travis-ci.org/libscie/datr)
[![Coverage status](https://codecov.io/gh/libscie/datr/branch/master/graph/badge.svg)](https://codecov.io/github/libscie/datr?branch=master)

The goal of datr is to provide R users with an easy way to interact with the [Dat](https://datproject.org) p2p infrastructure. Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms. If you are having issues, please check out the [Known Issues](#known-issues) below.

## Installation

You can install `datr` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("libscie/datr")
```

See below for [Windows](#windows), [Mac](#mac), and [Linux](#linux) specific instructions for installing Dat. `v0.1.0` will be submitted to CRAN (almost done 🏁)!

### Windows

Fire up `R` *with* Administrator privileges by right clicking the icon and selecting "Run as administrator"

[![Run as administrator](assets/run-as-admin.png)](https://winaero.com/blog/how-to-run-an-app-as-administrator-in-windows-10/)

Once the program launches, run `datr::dat_install()`. The package then initiates downloading Dat and installs it on your local machine. 

Upon completion, reboot R and you can start using the package 😻 (adminstrator privileges no longer needed)

### Mac

```R
devtools::install_github('libscie/datr', ref = 'install')
datr::dat_install(os = 'macos')
```

Note that there currently is an issue out that could benefit from feedback on installation on Mac (#7).

### Linux

Run `datr::dat_install(os = 'linux')` from your R console. There's no need to specify which flavor of Linux you're running, but you might to need to restart your R session 🙋

## Example

All functions that interface with the Dat network follow the semantics of `operation_dat()` (e.g., `install_dat` installs an R package from the provided Dat url). Some example code:

```R
datr::dat_install(os = 'linux')

datr::clone_dat('dat://0286381d95864386a83aadb136a60c1d09d079c5a4ff0e403fa126644ba4c6ab',
 dir = '~/test-datr/')

dir.create('~/test-datr-sharing')
setwd('~/test-datr-sharing')

datr::create_dat()

write.csv(data.frame(x = rnorm(100, 0, 1), y = rnorm(100, 50, 23)),
 '~/test-datr-sharing/test-data.csv',
 row.names = FALSE)

datr::sync_dat()
```

And in GIF form (because everything is nicer in GIFs)

![](assets/demo.gif)

## Roadmap

### v0.1.0

- [ ] Install Dat on your machine
- [x] Basic functionality of Dat
- [x] Install R packages hosted on Dat

## Code of conduct

This project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms. We welcome you with open arms if you are mindful and respectful of differences. You might not always understand another person's perspective; acknowledging that other people's feelings or perspectives are valid regardless of your understanding is prerequisite number one to being both mindful and respectful. We will not consider contributions if they are not done in a respectful manner, no matter how "genius" they might be.

## Known issues

* Rstudio does not like interactive console calls. Beware!

## License

All code is licensed GPLv3. All non-code assets are available under a [CC 0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/legalcode).
