fill_start <- function(vec, size, value = NA) {
  # fill
  fill_n <- size - length(vec)
  start <- rep(value, fill_n)
  c(start, vec)
}
