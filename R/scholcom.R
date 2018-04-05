#' Create scholarly profile
#' 
#' Create a scholarly profile on the Dat network. This follows the design
#' outlined in \url{https://dat-com-chris.hashbase.io}. Note, this creates
#' the profile in the working directory so be sure to first create a folder!
#' 
#' @dir Directory to create profile in. Specify without trailing slash.
#' 
#' @return Dat link to profile
#' @export

profile <- function (dir) {
  oldwd <- getwd()
  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  
  setwd(dir)
  create_dat()

  x <- list(type = 'scholarly-profile',
    follows = '[]',
    modules = '[]')

  sink('scholarly-metadata.json')
  cat(rjson::toJSON(x))
  sink()

  setwd(oldwd)
  return(rjson::fromJSON(file = sprintf('%s/dat.json', dir)$url)
}

#' Follow a scholarly profile
#' 
#' @param follow Dat link to scholarly profile to follow
#' @param profile Path to scholarly profile

follow <- function (follow, profile) {}

#' Create scholarly entry
#' 
#' @param author Dat link(s) to authors
#' @param parent Dat link(s) of parent entry
#' @param root Dat link(s) of root entry

entry <- function (author, parent, root) {}

#' Register scholarly entry to scholarly profile
#'
#' @param entry Dat link of entry
#' @param profile Dat link of profile

register <- function (entry, user) {}

