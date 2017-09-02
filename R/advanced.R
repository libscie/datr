# Advanced dat

install_dat <- function (link, dir = link, ...) {
  clone_dat(link, dir, ...)
  setwd(dir)
  built <- devtools::build(binary = TRUE, args = c('--preclean'))
  install.packages(built, repos = NULL, type = "source")

  system(sprintf('cd ../; rm -rf %s %s', dir, built))
}
