# bibliotecas -------------------------------------------------------------

require(vctrs)
require(purrr)

# dependencias ------------------------------------------------------------



# tests -------------------------------------------------------------------

files <- fs::dir_ls("test_data")
files <- dir("test_data", full.names = T)
test_file <- files[1]

# lines
lines <- vroom::vroom_lines(test_file) |>
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

start_score <- c(NA, rep(99, pl_n))
names(start_score) <- c("dealer", pl_names)

scores_df <- data.frame(t(sapply(scores,c))) |>
  tidyr::unnest(1)

scores_df <- tibble::tibble(t(sapply(scores,c)))
names(scores_df) <- c("dealer", pl_names)
dplyr::bind_rows(scores_df, start_score, .id = 1)
tidyr::unnest(scores_df, 1)
data.frame(t(start_score)) |>
  dplyr::bind_rows(scores_df)

