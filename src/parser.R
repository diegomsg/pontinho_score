# bibliotecas ####
library(readr)
library(stringr)
library(tidyr)
library(dplyr)
library(purrr)

# dplyr ####

## carrega raw ####
raw <- file.path("raw/raw1")
linhas <- read_lines(raw)
jogadores <- str_split_1(linhas[1], pattern = fixed(" "))

partida <- as_tibble(linhas[-1]) %>%
  rename(raw = value) %>%
  mutate(raw = stringr::str_squish(raw)) %>%
  mutate(dealer = map_vec(raw, ~str_match(., "^[[:alpha:]]*"))) %>%
  mutate(dealer = parse_character(dealer, na = c(""))) %>%
  mutate(pontos = str_split(raw, " ", simplify = F)) %>%
  mutate(pontos = map(pontos, ~tail(.x, length(jogadores)))) %>%
  unnest_wider(pontos, names_sep = "_") %>%
  select(-raw)

estouro <- function(p) {
  as.character(p) %>%
    str_replace("^[x|X]", "-100")
}

acumula_estouro <- function(vec) {
  stopifnot(is.vector(vec))
  indices <- which(vec < 0)
  valores <- vec[vec < 0]
  vec[indices] <- cumsum(valores)
  return(vec)
}

estouro_texto <- function(vec) {
  stopifnot(is.vector(vec))
  indices <- which(vec < 0)
  valores <- vec[vec < 0]/100 %>%
    trunc() %>%
    abs()
  texto <- purrr::map_vec(valores, ~strrep("X", .x))
  vec <- as.character(vec)
  vec[indices] <- texto
}

partida2 <- partida %>%
  mutate(across(!c(dealer), estouro)) %>%
  mutate(rodada = is.na(dealer)) %>%
  mutate(across(starts_with("pontos"), as.integer)) %>%
  mutate(across(is.integer, ~cumsum()))

