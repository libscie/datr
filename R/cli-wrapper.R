#' Share folder to network
#'
#' Function to continuously share working directory to the Dat network, until 
#' aborted.
#'
#' @export

share_dat <- function () {
  if (dir.exists('.dat')) {
    stop('Dat already initialized.')
  }

  system('dat share', wait = FALSE)
}

#' Create a Dat folder in current directory
#'
#' Function to create a dat.json interactively, with title and description.
#'
#' @return Dat link
#' @export

create_dat <- function () {
  system('dat create')

  res <- rjson::fromJSON(file = './dat.json')$url
  return(res)
}

#' Synchronize current folder with Dat network
#'
#' Function to resume sharing the folder with the Dat network, if already
#' created (\code{\link{create_dat}}) locally or cloned
#' (\code{\link{clone_dat}}).
#'
#' @export

sync_dat <- function () {
  system('dat sync')
}

#' Clone a Dat link to directory
#'
#' Function to clone a Dat link to the machine.
#'
#' @param link Dat link, including or without versioning (always clones latest)
#' @param dir Directory to clone to. If non-existent, will create.
#'
#' @return Nothing (for now)
#' @export
#'
#' @examples \dontrun{
#'   clone_dat(link = 'dat://a1b2c3...)
#'   clone_dat(link = 'dat://a1b2c3...+34)
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
#' Function to continuously update a Dat folder until abort. This function only
#' receives updates. 
#' 
#' @param dir Optional, path to Dat directory
#'
#' @return Nothing (for now)
#' @export

pull_dat <- function (dir = NULL) {
  if (is.null(dir)) {
    system('dat pull')
  } else {
    system(sprintf('dat pull %s', dir))
  }
}

#' Show the Dat log
#'
#' Function to show the log of the Dat folder. You can either retrieve the
#' log of a Dat link (argument \code{link}) or of a local Dat folder
#' (argument \code{dir}). Defaults to giving the log of the working directory.
#' If a Dat link is provided, this overrides the \code{dir} argument.
#'
#' @param link Dat link (network)
#' @param dir Dat folder (local)
#'
#' @return Nothing (for now)
#' @export

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
#' Get some information about a Dat folder, including the \code{link}, the
#' number of files, and the current version.
#'
#' @param dir Location of Dat folder. Defaults to working directory
#'
#' @return Nothing (for now)
#' @export

status_dat <- function (dir = '.') {
  system('dat status')
}
