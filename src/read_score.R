# dependencias ------------------------------------------------------------

require(fs)
require(vroom)
require(tidyr)
require(dplyr)
require(glue)
require(stringr)
source("src/fill_start.R")

# fun ---------------------------------------------------------------------

read_score <- function(file) {
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
