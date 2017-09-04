# Advanced dat

install_dat <- function (link, dir = link, ...) {
  clone_dat(link, dir, ...)

  devtools::install(dir)

  system(sprintf('cd ../; rm -rf %s', dir))
}
