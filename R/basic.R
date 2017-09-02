# Basic

cmd_dat <- function (cmd, dir, options = "") {
  system(sprintf("dat %s %s %s",
                 cmd,
                 dir,
                 paste(options)))
}

# Most likely this is a bad way of verifying. Help wanted.
# Also not able to resolve hashbase links atm (enhancement)
verify_dat <- function (link) {
  if (!nchar(link) == 64) {
    stop("Incorrect dat link.")
  }
}

# Sharing

# Creates dat in working directory
create_dat <- function () {
  cmd_dat("create")
}

# Synchronizes working directory to dat if created
sync_dat <- function () {
  cmd_dat("sync")
}

# Create and sync in one fell swoop
share_dat <- function () {
  cmd_dat("share")
}

# Downloading

clone_dat <- function (link, dir = link, ...) {
  verify_dat(link)
  cmd_dat("clone", link, paste(dir, ...))
}

pull_dat <- function (dir, options) {
  cmd_dat("pull", dir, options)
}

