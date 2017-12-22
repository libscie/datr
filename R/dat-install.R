#' Install R package from Dat link
#'
#' Directly install an R package from a Dat link.
#'
#' @param link Dat link
#'
#' @return Message.
#' @export
#'
#' @examples \dontrun{
#'   dat_install('dat://datr-chris.hashbase.io')
#' }

dat_install <- function (link) {
  dir <- 'tmp'
  dat_clone(link, dir)

  devtools::install(dir)

  unlink(dir, recursive = TRUE)

  message('Successfully installed package from Dat network')
}

#' Install Dat from npm
#' 
#' Directly install Dat from npm. If node + npm are not yet available, the 
#' function will first try to install these. NOTE: at the moment the
#' install_mac() and install_windows() functions have not been tested (TBD).
#' 
#' @param os 'windows', 'mac', or 'linux'
#' @param pkg Package manager (only for linux; typically 'apt' or 'dnf')
#' 
#' @return NULL. Prints stdout of terminal along the way.
#' @export

install_dat <- function (os = 'windows', pkg = 'apt') {
  tryCatch(system('npm -v'), 
    finally = install_node(os = os, pkg = pkg))
  system('npm install -g dat')
}
