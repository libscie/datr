#' Create Dat metadata
#'
#' Function to create a dat.json interactively, with title and description.
#'
#' @param dir Directory to create Dat. Defaults to working directory.
#' 
#' @export
#' 
#' @examples 
#'   create_dat(dir = tempdir())

create_dat <- function (dir = '.') {
  system(sprintf('dat create %s', dir))
}

#' Share folder to network
#'
#' Share directory to the Dat network, until aborted. Requires write access 
#' to Dat archive.
#' 
#' @param dir Directory to share. Defaults to working directory.
#'
#' @export
#'
#' @examples 
#'   share_dat(dir = tempdir()) 

share_dat <- function (dir = '.') {
  system(sprintf('dat share %s', dir), wait = FALSE)
}

#' Clone a Dat link to directory
#'
#' Function to clone a Dat link to the machine.
#'
#' @param link Dat link (always clones latest version now)
#' @param dir Directory to clone to. If non-existent, will create.
#'
#' @export
#'
#' @examples \dontrun{
#'   clone_dat(link = 'dat://datr-chris.hashbase.io', dir = tempdir())
#' }

clone_dat <- function (link, dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  
  system(sprintf('dat clone %s %s', link, dir))
}

#' Update Dat folder
#'
#' Function to update working directory if it is a Dat folder. This function
#' only receives updates. 
#'
#' @export
#' @examples \dontrun{
#'   pull_dat()
#' }

pull_dat <- function () {
  system('dat pull')
}

#' Synchronize with Dat network
#'
#' Synchronize directory with the Dat network. If write access to the Dat is 
#' available, this is equivalent to \code{\link{share_dat}}. If read-only 
#' access is available, this is equivalent to \code{\link{pull_dat}}. 
#'
#' @export
#' @examples \dontrun{
#'   sync_dat()
#' }

sync_dat <- function () {
  system('dat sync')
}

#' Show Dat archive log
#'
#' Retrieve log of the Dat folder. You can either retrieve the
#' log of a Dat link (argument \code{link}) or of a local Dat folder
#' (argument \code{dir}). Defaults to giving the log of the working directory.
#' If a Dat link is provided, this overrides the \code{dir} argument.
#'
#' @param path Dat archive, can both be local or on the network.
#'
#' @return Console log.
#' @export
#' @examples \dontrun{
#'   log_dat(path = '.')
#'   log_dat(path = 'dat://pastedat-taravancil.hashbase.io')
#' }

log_dat <- function (path) {
  system(sprintf('dat log %s', path))
}

#' Status of the Dat folder
#'
#' Get some information Dat folder in the working directory. Includes: Dat 
#' link, the number of files, and the current version.
#'
#' @return Console log.
#' @export
#' @examples \dontrun{
#'   status_dat()
#' }

status_dat <- function () {
  system('dat status')
}
