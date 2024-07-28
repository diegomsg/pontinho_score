# dependencias ------------------------------------------------------------

source("src/game_id.R")
source("src/read_score.R")

# fun ---------------------------------------------------------------------

read_game_info <- function(file) {
  stopifnot(
    "must be a file" = fs::is_file(file)
  )
  list(
    id = game_id(file),
    score = read_score(file)
  )
}
