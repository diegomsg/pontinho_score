# dependencias ------------------------------------------------------------

require(S7)


# methods ------------------------------------------------------------------

method(is.na, ponto) <- function(self) {
  props(self) |>
    is.na() |>
    any()
}
