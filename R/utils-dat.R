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
    stop('Unknown Dat command. Please check the docs; ?datr::dat')
  }
}

#' Verify Dat gateway
#' 
#' Dat links can either be 64-character hex based, or be used in conjunction
#' with a gateway (e.g., \url{dat://datr-chris.hashbase.io}). If a gateway is
#' used, this function can be used to resolve the gateway to a hash for 
#' validation.
#' 
#' TO BE IMPLEMENTED. Will probably require handling of the \code{dat-node}
#' javascript implementation of Dat (see 
#' \url{https://github.com/datproject/dat-node}). Help greatly appreciated!
#' 
#' @param x Dat gateway link to verify
#' 
#' @return Boolean TRUE [invisible]

verify_gateway <- function (x) {
  invisible(TRUE)
}

#' Verify Dat link
#'
#' This function verifies a Dat link with a heuristic, checking for a 64 
#' character hash plus an optional version number. Resolving gateways such
#' as \url{https://hashbase.io} will be implemented later.
#'
#' @param x Dat link to verify.
#'
#' @return Boolean TRUE [invisible]

verify_dat <- function (x) {
  if (!sum(grepl(x, pattern = '^(dat:/{2})\\w{64}(\\+\\d)?$')) == length(x)) {
    stop('Supplied Dat links contain errors. Please verify input.')
  }
  
  invisible(TRUE)
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

install_node_mac <- function () {
  cmd <- '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  tmp <- system('brew')
  
  if (tmp != 1 || tmp != 0) {
    cat('Brew not installed.\n')
    cat('Installing from https://raw.githubusercontent.com/Homebrew/install/master/install.\n')
    system(cmd)
  }

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

install_node_windows <- function () {
  cmd <- '@"%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString(\'https://chocolatey.org/install.ps1\'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\\chocolatey\\bin"'
  tmp <- system('choco')
  
  if (tmp != 1 || tmp != 0) {
    cat('Chocolatey package manager not installed.\n')
    cat('Installing from https://chocolatey.org/install.ps1.\n')
    system(cmd)
  }

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
#'   \code{dnf}). No checks for type of manager at the moment, so adjust
#'   at own discretion.
#' 
#' @return Nothing. Prints terminal output.

install_node_linux <- function (pkg = 'apt') {
  system(sprintf('sudo %s install nodejs', pkg))
}

#' Wrap node install functions across OS
#' 
#' @param os 'windows', 'mac', or 'linux'
#' @param pkg Package manager [only for 'linux']
#' 
#' @return Nothing. Prints terminal output.

install_node <- function(os, pkg) {
  if (os == 'mac' && !npm_avail()) {
    install_node_mac()
  } else if (os == 'windows' && !npm_avail()) {
    install_node_windows()
  } else if (os == 'linux' && !npm_avail()) {
    install_node_linux(pkg = pkg)
  } else {
    stop('Unexpected error. Please post an issue to github.com/libscie/datr
      with your sessionInfo() output and error log (thanks!).')
  }
}

#' Helper function for npm availability
#' 
#' @return TRUE if available.

npm_avail <- function () {
  x <- system('npm -v')
  if (x == 1 || x == 0) {
    return(TRUE)
  }
} 

# To do
update_npm <- function () {}

#' Install Dat from npm
#' 
#' Directly install Dat from npm. If node + npm are not yet available, the 
#' function will first try to install these. NOTE: at the moment the
#' install_node_mac() and install_node_windows() functions have not been tested (TBD).
#' 
#' @param os 'windows', 'mac', or 'linux'
#' @param pkg Package manager (only for linux; typically 'apt' or 'dnf')
#' 
#' @return NULL. Prints stdout of terminal along the way.
#' @export

install_dat <- function (os = 'windows', pkg = 'apt') {
  if (!npm_avail()) {
    install_node(os, pkg)
  }
  system('npm install -g dat')
}
