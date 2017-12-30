#' Checking the command to be passed to Dat system call
#'
#' @param x Command to check

cmd_check <- function (x) {
  if (!x %in% c('share',
                'create',
                'sync',
                'clone',
                'pull',
                'sync',
                'log',
                'status')) {
    stop('Unknown Dat command. Please check the docs ?datr::dat.')
  }
}

#' Verify the protocol of a Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_protocol <- function (x) {
  splits <- stringr::str_split(x, pattern = '://')
  res <- lapply(splits, function (y) y[1] == 'dat')

  if (!sum(res == TRUE) == length(splits)) {
    stop('Not all supplied protocols are dat.')
  }

  invisible(TRUE)
}

#' Verify the hash of a Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_hash <- function (x) {
  splits <- stringr::str_split(x, pattern = '://')
  # Verify hash length for unversioned and versioned Dat links
  res <- lapply(splits, function (y) {
    nchar(y[2]) == 64 | verify_version(y[2])
  })

  if (!sum(res == TRUE) == length(splits)) {
    stop('Not all supplied protocols are 64 character hashes.')
  }

  invisible(TRUE)
}

#' Verify a versioned Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_version <- function (x) {
  splits <- stringr::str_split(x, pattern = '\\+')
  res <- lapply(splits, function (z) {
    nchar(z[1]) == 64 && grepl(z[2], pattern = '\\d+')
  })

  invisible(TRUE)
}

#' Verify Dat gateway
#' 
#' Dat links can either be 64-character hex based, or be used in conjunction
#' with a gateway (e.g., \url{dat://datr-chris.hashbase.io} for this package)
#' 
#' @param x Dat gateway link to verify

verify_gateway <- function (x) {
  invisible(TRUE)
}

#' Verify Dat link on various aspects
#'
#' This function provides a wrapper for the various aspects of a Dat link
#' such as the protocol (\code{\link{verify_protocol}}), the hash
#' (\code{\link{verify_hash}}) and the gateway (\code{\link{verify_gateway}};
#' not yet implemented).
#'
#' @param x Dat link to verify.
#'
#' @return Boolean TRUE [invisible]

verify_pipeline <- function (x) {
  if (is.null(x)) {
    stop('Please provide a Dat link.')
  }
  verify_protocol(x)
  verify_hash(x)
}

#' Install node with brew on Mac
#' 
#' In order to install Dat, npm needs to be available on the system call. 
#' This becomes available when nodeJS (\url{https://nodejs.org}) is available.
#' Using Brew (\url{https://brew.sh/}), this function installs node. 
#' 
#' The function wraps a system call that gets an install script and uses Ruby
#' to install it. 
#' 
#' @return Nothing. Prints terminal output.
#' @export

install_mac <- function () {
  cmd <- '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

  tryCatch(system('brew'),
    finally = system(cmd))
  system('brew node')
}

#' Install node with Chocolatey on windows
#' 
#' In order to install Dat, npm needs to be available on the system call. 
#' This becomes available when nodeJS (\url{https://nodejs.org}) is available.
#' Using Chocolatey (\url{https://chocolatey.org/}), this function installs 
#' node. 
#' 
#' The function wraps a system call that gets the install script from
#' Chocolatey.
#' 
#' @return Nothing. Prints terminal output.
#' @export

install_windows <- function () {
  cmd <- '@"%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString(\'https://chocolatey.org/install.ps1\'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin"'

  tryCatch(system('choco'), 
    finally = system(cmd))
  system('choco install nodejs')
}

#' Install node on Linux
#' 
#' In order to install Dat, npm needs to be available on the system call. 
#' This becomes available when nodeJS (\url{https://nodejs.org}) is available.
#' Using the specified package manager (usually \code{apt} [Debian based] or
#' \code{dnf} [Redhat based]), this function installs node. 
#' 
#' In order to ensure sudo is not needed to install with \code{npm} in 
#' \code{install_dat()}, the NODE_PATH is exported into the user's .profile
#' 
#' @param pkg Package manager of Linux distro (typically \code{apt} or 
#'   \code{dnf})
#' 
#' @return Nothing. Prints terminal output.
#' @export

install_linux <- function (pkg = 'apt') {
  cmd <- sprintf('sudo %s install nodejs', pkg)
  system(cmd)
  system('echo export NODE_PATH=~/.npm-global/lib/node_modules/ >> .profile')
}

#' Wrap node install functions across OS
#' 
#' @param os 'windows', 'mac', or 'linux'
#' @param pkg Package manager [only for 'linux']
#' 
#' @return Nothing. Prints terminal output.

install_node <- function(os, pkg) {
  if (os == 'mac') {
    install_mac()
  } else if (os == 'windows') {
    install_windows()
  } else if (os == 'linux') {
    install_linux(pkg = pkg)
  } else {
    stop('Unexpected error. Please post an issue to github.com/libscie/datr')
  }
}

# To do
update_npm <- function () {}