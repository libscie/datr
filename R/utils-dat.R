#' Checking the command to be passed to Dat system call
#'
#' @param x Command to check

cmd_check <- function (x) {
  if (!x %in% c('share',
                'create',
                'sync',
                'clone',
                'pull',
                'sync',
                'log',
                'status')) {
    stop('Unknown Dat command. Please check the docs ?datr::dat.')
  }
}

#' Verify the protocol of a Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_protocol <- function (x) {
  splits <- stringr::str_split(x, pattern = '://')
  res <- lapply(splits, function (y) y[1] == 'dat')

  if (!sum(res == TRUE) == length(splits)) {
    stop('Not all supplied protocols are dat.')
  }

  invisible(TRUE)
}

#' Verify the hash of a Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_hash <- function (x) {
  splits <- stringr::str_split(x, pattern = '://')
  # Verify hash length for unversioned and versioned Dat links
  res <- lapply(splits, function (y) {
    nchar(y[2]) == 64 | verify_version(y[2])
  })

  if (!sum(res == TRUE) == length(splits)) {
    stop('Not all supplied protocols are 64 character hashes.')
  }

  invisible(TRUE)
}

#' Verify a versioned Dat link
#'
#' @param x Dat link
#'
#' @return Boolean TRUE [invisible]

verify_version <- function (x) {
  splits <- stringr::str_split(x, pattern = '\\+')
  res <- lapply(splits, function (z) {
    nchar(z[1]) == 64 && grepl(z[2], pattern = '\\d+')
  })

  invisible(TRUE)
}

# TO DO
verify_gateway <- function () {
  invisible(TRUE)
}

#' Verify Dat link on various aspects
#'
#' This function provides a wrapper for the various aspects of a Dat link
#' such as the protocol (\code{\link{verify_protocol}}), the hash
#' (\code{\link{verify_hash}}) and the gateway (\code{\link{verify_gateway}};
#' not yet implemented).
#'
#' @param x Dat link to verify.
#'
#' @return Boolean TRUE [invisible]

verify_pipeline <- function (x) {
  if (is.null(x)) {
    stop('Please provide a Dat link.')
  }
  verify_protocol(x)
  verify_hash(x)
}
