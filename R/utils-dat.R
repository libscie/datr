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
#' @note The system `PATH` will be modified. On Linux-ish systems, \code{~/.profile}
#'       will also be modified.
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

  message("Modifying system PATH to enable easier access to 'dat'...")

  # These still use `system()` vs `system2()`
  if (os == 'win') {
    system(paste0('SETX /M PATH "%PATH%;',
     paste0(normalizedPath, destpath), '"'))
  } else {
    system(sprintf("echo 'export PATH=$PATH:%s' >> ~/.profile", normalizedPath))
  }
}

# tests whether we can find dat
dat_is_installed <- function(quiet = TRUE) {

  # try to get the dat version number since that's more robust than
  # just executing it or trying to find the file since it means both
  # the PATH is setup right and the utility is functioning.

  # 'dat' does not conform to traditional cli standards and returns 1 on
  # successful completion of 'dat --version' so we suppress messages/warnings.

  try(
    suppressMessages(
      suppressWarnings(
        system2("dat", args = "--version", stdout = TRUE, stderr = TRUE)
      )
    ),
    silent = TRUE
  ) -> res

  found <- !inherits(res, "try-error")

  if ((!found) && (!quiet)) {
    warning(
      paste0(
        "'dat' not found. Please install it with dat_install() or ensure that the",
        "path to it is on the system PATH if you know it is installed.",
        collapse = " "
      )
    )
  }

  return(found)

}
