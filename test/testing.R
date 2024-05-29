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


