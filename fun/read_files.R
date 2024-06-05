
# bibliotecas -------------------------------------------------------------


# dependencias ------------------------------------------------------------

require(fs)
require(vroom)
require(tidyr)
require(dplyr)
require(glue)
require(stringr)

# fun ---------------------------------------------------------------------

fill_start <- function(vec, size, value = NA) {
  # fill
  fill_n <- size - length(vec)
  start <- rep(value, fill_n)
  c(start, vec)
}

read_score <- function(file) {
  stopifnot(
    is_file = fs::is_file(file)
  )
  lines <- vroom::vroom_lines(file) |>
    strsplit("\\s+")

  # players
  pl_names <- lines[[1]]
  pl_n <- length(pl_names)

  # scores rows
  scores <- lines[2:length(lines)]
  scores_n <- length(scores)

  # fix scores
  row_sizes <- map(scores, length) |> unlist(recursive = F)
  low_scores_ind <- which(row_sizes <= pl_n)
  scores[low_scores_ind] <- map(scores[low_scores_ind], ~fill_start(.x, pl_n + 1))

  # dealer col and initial points
  start_score <- c(NA, rep(99, pl_n)) |>
    as.character()
  names(start_score) <- c("dealer", pl_names)

  # scores lines to dataframe cols
  scores_df <- data.frame(t(sapply(scores,c))) |>
    tidyr::unnest(1)
  colnames(scores_df) <- c("dealer", pl_names)

  dplyr::bind_rows(start_score, scores_df)
}

game_id <- function(file) {
  stopifnot(
    is_file = fs::is_file(file)
  )
  filename <- basename(test_file) |>
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
