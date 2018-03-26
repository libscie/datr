#' Install R package from Dat link
#'
#' Directly install an R package from a Dat link.
#'
#' @param link Dat link
#' @param dir Temporary directory to store download in.
#'
#' @return Console log.
#' @export
#'
#' @examples \dontrun{
#'   install_dat('dat://datr-chris.hashbase.io', dir = tempdir())
#' }

install_dat <- function (link, dir) {
  clone_dat(link, dir)
  devtools::install(dir)

  unlink(dir, recursive = TRUE)

  message('Successfully installed package from Dat network')
}
