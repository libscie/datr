# datr 0.1.0

* `dat_install()`: Install Dat binaries
* `ACTION_dat()`, where `ACTION` is replacable with: 
  * `clone` => create local copy of Dat filesystem
  * `create` => interactively create a Dat filesystem in working directory
  * `share` => initialize Dat filesystem (without metadata) and synchronize
  * `sync` => restore synchronization of working directory with Dat network
  * `pull` => update local copy of Dat filesystem remote updates
  * `log` => show the append-only log of the working directory Dat
  * `status` => show information about Dat filesystem (link, size, version)
* `install_dat()`: Install an R package hosted on the Dat network
* RStudio does not like interactive system calls, which this package is based on (see also issue #8). Beware! 

