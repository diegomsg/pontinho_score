# bibliotecas -------------------------------------------------------------

require(vctrs)
require(purrr)

# dependencias ------------------------------------------------------------

source("fun/read_files.R")

# tests -------------------------------------------------------------------

## test file ---------------------------------------------------------------
files <- fs::dir_ls("test_data")
files <- dir("test_data", full.names = T)
test_file <- files[1]

## content -----------------------------------------------------------------
content <- read_score(test_file)

id <- game_id(test_file)
