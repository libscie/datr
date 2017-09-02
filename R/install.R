setup_dat <- function () {
  cat("You're running on", get_os(), "\n")

  cat("Node version", tryCatch(check_node(), finally = install_node()))
  cat("dat version", tryCatch(check_dat(), finally = install_dat()))
}

# Retrieved from https://github.com/r-lib/rappdirs/blob/master/R/utils.r#L1
get_os <- function() {
  if (.Platform$OS.type == "windows") {
    "win"
  } else if (Sys.info()["sysname"] == "Darwin") {
    "mac"
  } else if (.Platform$OS.type == "unix") {
    "unix"
  } else {
    stop("Unknown OS")
  }
}

check_node <- function () {
  res <- system('node -v')
  if (res == 0) {
    stop("Node not found. If already installed, ensure it's in PATH")
  }
}

check_dat <- function () {
  res <- system('dat -v')
  if (res == 1) {
    stop("dat not found. If already installed, ensure it's in PATH")
  }
}

install_datcli <- function () {
  system('npm install -g dat')
}

install_node <- function () {
  cat("Please download and install NodeJS from https://nodejs.org/en/download")

  res <- readline(prompt = "Press ENTER when done.")
}
