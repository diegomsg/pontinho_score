id_to_name <- function(x, names) {
  if (is.na(x)) {
    NA
  } else {
    names[grep(paste0("^", x), names)]
  }
}

ids_to_names <- function(ids, names) {
  sapply(ids, id_to_name, names = names, USE.NAMES = F)
}
