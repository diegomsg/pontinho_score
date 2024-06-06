# dependencias ------------------------------------------------------------

require(S7)


# classes -----------------------------------------------------------------

ponto <- new_class(
  "ponto",
  properties = list(
    x = class_integer,
    win = class_logical,
    pop = class_logical
  ),
  validator = function(self) {
    if(!is.na(self@x)) {
      if(self@x < 0) {"@x não pode ser menor que 0"}
      if(self@x > 99) {"@x não pode ser maior que 99"}
    } else {
      if(self@win) {"@x não pode bater sem pontuação"}
      # se jogador estourar e abandonar jogo, self@x = NA e self@pop = T
    }
  }
)

mao <- new_class(
  "mao",
  properties = list(
    ini = class_integer,
    mao = class_integer,
    fim = ponto
  ),
  validator = function(self) {
    if(!is.na(self@fim)) {
      if(self@fim@x > self@ini) {"@fim não pode ser maior que @ini"}
    }
  }
)

