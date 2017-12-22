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

# Install Dat using npm

install_dat <- function () {
  system('npm install -g dat')
}