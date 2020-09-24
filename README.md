# `datr` <img src="https://raw.githubusercontent.com/libscie/datr/master/assets/datr-data-logo.svg.png" width=64 align="right"/>

[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors)
[![CRAN
status](https://www.r-pkg.org/badges/version/retractcheck)](https://cran.r-project.org/package=retractcheck)
[![CRAN\_Downloads\_Total](http://cranlogs.r-pkg.org/badges/grand-total/retractcheck?color=brightgreen)](https://cran.r-project.org/package=retractcheck)

`datr` allows R users to interact with the [Dat](https://datproject.org) network. You can load, store, or share data on the Dat network, without including any intermediaries that can snoop on your content. All transfers are end-to-end encrypted.

## Example

![GIF of demo](https://raw.githubusercontent.com/libscie/datr/master/assets/demo.gif)

or in plain text

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



## Installation

You can install `datr` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("libscie/datr")
```

See below for [Windows](#windows), [Mac](#mac), and [Linux](#linux) specific instructions for installing Dat. `v0.1.0` will be submitted to CRAN (almost done 🏁)!

### Windows

Fire up `R` *with* Administrator privileges by right clicking the icon and selecting "Run as administrator"

[![Run as administrator](https://raw.githubusercontent.com/libscie/datr/master/assets/run-as-admin.png)](https://winaero.com/blog/how-to-run-an-app-as-administrator-in-windows-10/)

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

## Code of conduct

This project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms. We welcome you with open arms if you are mindful and respectful of differences. You might not always understand another person's perspective; acknowledging that other people's feelings or perspectives are valid regardless of your understanding is prerequisite number one to being both mindful and respectful. We will not consider contributions if they are not done in a respectful manner, no matter how "genius" they might be.

## License

All code is licensed GPLv3. All non-code assets are available under a [CC 0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/legalcode).

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://chjh.nl"><img src="https://avatars0.githubusercontent.com/u/2946344?v=4" width="100px;" alt="Chris Hartgerink"/><br /><sub><b>Chris Hartgerink</b></sub></a><br /><a href="#maintenance-chartgerink" title="Maintenance">🚧</a> <a href="https://github.com/libscie/datr/commits?author=chartgerink" title="Code">💻</a> <a href="#design-chartgerink" title="Design">🎨</a></td><td align="center"><a href="http://rud.is/b"><img src="https://avatars2.githubusercontent.com/u/509878?v=4" width="100px;" alt="boB Rudis"/><br /><sub><b>boB Rudis</b></sub></a><br /><a href="https://github.com/libscie/datr/commits?author=hrbrmstr" title="Code">💻</a></td></tr></table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
