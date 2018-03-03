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
#'   install_dat('dat://datr-chris.hashbase.io')
#' }

install_dat <- function (link) {
  dir <- 'tmp'
  clone_dat(link, dir)

  devtools::install(dir)

  unlink(dir, recursive = TRUE)

  message('Successfully installed package from Dat network')
}
