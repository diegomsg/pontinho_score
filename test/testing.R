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


## name --------------------------------------------------------------------
filename <- basename(test_file) |>
  sub("(?<!^|[.]|/)[.][^.]+$", "", x = _, perl = TRUE)

seps_regex <- "[-|_|.]"
pattern <- glue::glue("^(?<date>\\d{2,4}{{seps_regex}}\\d{1,}[-|_]\\d{1,})(?:{{seps_regex}})(?<page>\\d*)(?:{{seps_regex}})?(?<seq>\\d*)?",
                         .open = "{{", .close = "}}")
matches <- stringr::str_match(filename, pattern)
str(matches)
id <- list(filename = matches[1],
           date = as.Date(matches[2]),
           page = as.integer(matches[3]),
           seq = as.integer(matches[4]))

