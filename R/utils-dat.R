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

#' Install Dat
#' 
#' Download the released binaries for Dat and add them to your environment. If
#' a more recent version has been released, you can specify it as argument (we
#' try to update it accordingly, but might sometimes have time off!).
#' 
#' @param os 'win' (Windows), 'mac', or 'linux'
#' @param ver Version. See \url{https://github.com/datproject/dat/releases}
#' 
#' @return NULL. Prints stdout of terminal along the way.
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @export

dat_install <- function (os = 'win', ver = '13.10.0') {
  if (!(os == 'win' || os == 'macos' || os == 'linux')) {
    stop('Please specify operating system correctly.')
  }
  
  suppressWarnings(dir.create(normalizePath('~/.datr', winslash = '\\')))

  url <- sprintf('https://github.com/datproject/dat/releases/download/v%s/dat-%s-%s-x64.zip',
    ver, ver, os)
  download.file(url,
   destfile = 'dat.zip')

  unzip('dat.zip', exdir = normalizePath('~/.datr', winslash = '\\'))
  file.remove('dat.zip')

  if (os == 'win') {
    system(paste0('SETX /M PATH "%PATH%;',
     normalizePath(sprintf('~/.datr/dat-%s-%s-x64', ver, os),
      winslash = '\\'), '"'))
  } else {
    system(sprintf("echo 'export PATH=$PATH:/home/$USER/.datr/dat-%s-%s-x64' >> ~/.profile", ver, os))
  }
}
