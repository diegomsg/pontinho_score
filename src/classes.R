# dependencias ------------------------------------------------------------

require(S7)


# properties --------------------------------------------------------------

prop_ponto <- new_property(
  #pontos na mão do jogador
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

ponto_mao <- new_class(
  "ponto_mao",
  #pontos com estouro e acumulado na mão do jogador
  properties = list(
    pontos = prop_ponto,
    estouro = new_property(
      class = class_logical,
      default = FALSE
    ),
    n_estouro = new_property(
      class = class_integer,
      default = 0L
    )
  )
)

mao <- new_class(
  "mao",
  properties = list(
    ponto_inicial = prop_ponto,
    ponto_mao = ponto_mao,
    ponto_final = list(
      apurado = prop_ponto,
      calculado = new_property(
        class = class_integer,
        getter = function(self) {self@ponto_inicial == self@ponto_mao@pontos}
      ),
      validado = new_property(
        class = class_logical,
        getter = function(self) {self@ponto_final@apurado == self@ponto_final@calculado}
      )
    )
  ),
  validator = function(self) {
    if(!is.na(self@fim)) {
      if(self@fim@x > self@ini) {"@fim não pode ser maior que @ini"}
    }
    if(!is.na(self@x)) {
      if(self@win) {"@x não pode bater sem pontuação"}
      # se jogador estourar e abandonar jogo, self@x = NA e self@pop = T
    }
  }
)

