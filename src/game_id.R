game_id <- function(file) {
  filename <- basename(file) |>
    sub("(?<!^|[.]|/)[.][^.]+$", "", x = _, perl = TRUE)

  seps_regex <- "[-|_|.]"
  pattern <- glue::glue("^(?<date>\\d{2,4}{{seps_regex}}\\d{1,}[-|_]\\d{1,})(?:{{seps_regex}})(?<page>\\d*)(?:{{seps_regex}})?(?<seq>\\d*)?",
                        .open = "{{", .close = "}}")
  matches <- stringr::str_match(filename, pattern)
  list(id = matches[1],
       date = as.Date(matches[2]),
       page = as.integer(matches[3]),
       seq = as.integer(matches[4]))
}
