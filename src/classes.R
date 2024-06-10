# dependencias ------------------------------------------------------------

require(S7)


# properties --------------------------------------------------------------

prop_ponto <- new_property(
  class = class_integer,
  validator = function(value) {
    if(length(value) != 1) {"precisa ser unitário"}
    if(!is.na(value)) {
      if(value < 0) {"não pode ser menor que 0"}
      if(value > 99) {"não pode ser maior que 99"}
    }
    # pode ser vazio, ou entre 0 e 99
  }
)


# classes -----------------------------------------------------------------

mao <- new_class(
  "mao",
  properties = list(
    ini = prop_ponto,
    mao = prop_ponto,
    fim = list(
      informado = class_integer,
      calculado = new_property(
        class_integer,
        getter = function(self) {self@}
      )
    )
    fim_informado = prop_ponto,
    consistente = new_property(
      class = class_logical,
      setter = function(self) {self@fim_informado == self@ini - self@mao}
    ),
    fim = new_property(
      class = ponto,
      setter = function(self) {self@ini - self@mao}
    ),
    win = new_property(class_logical, default = F),
    pop = new_property(class_logical, default = F)
  ),
  validator = function(self) {
    if(!is.na(self@fim)) {
      if(self@fim@x > self@ini) {"@fim não pode ser maior que @ini"}
    }
    if(!is.na(self@x)) {
      if(self@win) {"@x não pode bater sem pontuação"}
      # se jogador estourar e abandonar jogo, self@x = NA e self@pop = T
  }
)

