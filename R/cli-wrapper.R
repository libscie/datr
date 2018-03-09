#' Create Dat metadata
#'
#' Function to create a dat.json interactively, with title and description.
#'
#' @param dir Directory to create Dat.
#' 
#' @export
#' 
#' @examples \dontrun{
#'   create_dat('.')
#'   create_dat('data/')
#' }

create_dat <- function (dir) {
  system('dat create')
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
#' @examples \dontrun{
#'   share_dat('./') 
#'   share_dat('data/') 
#'   share_dat('materials/') 
#' }

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
#'   clone_dat(link = 'dat://datr-chris.hashbase.io')
#' }

clone_dat <- function (link, dir) {
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  
  verify_dat(link)

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
#' @param link Dat link (network)
#' @param dir Dat folder (local)
#'
#' @return Console log.
#' @export
#' @examples \dontrun{
#'   log_dat()
#'   log_dat(link = 'dat://pastedat-taravancil.hashbase.io')
#' }

log_dat <- function (link, dir = '.') {
  if (exists(x = 'link')) {
    verify_dat(link)
    cmd <- sprintf('dat log %s', link)
  } else {
    cmd <- sprintf('dat log %s', dir)
  }

  system(cmd)
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
