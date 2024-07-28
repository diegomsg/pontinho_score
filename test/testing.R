# bibliotecas -------------------------------------------------------------

require(purrr)

# dependencias ------------------------------------------------------------

source("src/read_game_info.R")

# tests -------------------------------------------------------------------

## test file ---------------------------------------------------------------
files <- fs::dir_ls("test_data")
files <- dir("test_data", full.names = T)
test_file <- files[1]

## content -----------------------------------------------------------------
game <- read_game_info(test_file)

