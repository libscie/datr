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

#' Dat install
#' 
#' Download the released binaries for Dat and add them to your environment. If
#' a more recent version has been released, you can specify it as argument (we
#' try to update it accordingly, but might sometimes have time off!).
#' 
#' @param os 'win' (Windows), 'mac', or 'linux'
#' @param path Where to install Dat
#' @param ver Version. See \url{https://github.com/datproject/dat/releases}
#' 
#' @return NULL. Prints stdout of terminal along the way.
#' @importFrom utils download.file
#' @importFrom utils unzip
#' @export
#' @examples \dontrun{
#'   dat_install(os = 'win')
#'   dat_install(os = 'macos')
#'   dat_install(os = 'linux')
#' }

dat_install <- function (os = 'win', path, ver = '13.10.0') {
  if (!(os == 'win' || os == 'macos' || os == 'linux')) {
    stop('Please specify operating system correctly (win|macos|linux).')
  }
  
  normalizedPath <- suppressWarnings(
    normalizePath(path, winslash = '\\')
  )
  if (os == 'win') {
    dest <- '\\dat.zip'
    destpath <- sprintf('\\dat-%s-%s-x64', ver, os)
  } else {
    dest <- '/dat.zip'
    destpath <- sprintf('/dat-%s-%s-x64', ver, os)
  }

  normalizedDest <- paste0(normalizedPath, dest)
  dir.create(normalizedPath)

  url <- sprintf('https://github.com/datproject/dat/releases/download/v%s/dat-%s-%s-x64.zip',
    ver, ver, os)
  download.file(url,
   destfile = normalizedDest)

  unzip(normalizedDest, exdir = normalizedPath)
  file.remove(normalizedDest)

  if (os == 'win') {
    system(paste0('SETX /M PATH "%PATH%;',
     paste0(normalizedPath, destpath), '"'))
  } else {
    system(sprintf("echo 'export PATH=$PATH:%s' >> ~/.profile", normalizedPath))
  }
}
