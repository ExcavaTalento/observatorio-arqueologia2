source("R/00_paquetes.R")

encuesta <- read_csv(
  "data/processed/encuesta_procesada.csv",
  show_col_types = FALSE
)

# Ver categorías únicas
sort(unique(encuesta$edad))

sort(unique(encuesta$experiencia))

sort(unique(encuesta$formacion))

sort(unique(encuesta$ingreso))

sort(unique(encuesta$volveria_estudiar))


#========================================================
# 04_transformar_variables.R
# Transformación final: factores ordenados + recodificaciones
# Salida: data/processed/encuesta_dashboard.csv
#========================================================

source("R/00_paquetes.R")

encuesta <- read_csv(
  "data/processed/encuesta_procesada.csv",
  show_col_types = FALSE
)

#--------------------------------------------------------
# 1. ACTIVO
#    "Soy docente de bioarqueología en una universidad
#    pública" -> se recodifica como "Sí, es mi profesión
#    principal"
#--------------------------------------------------------

encuesta <- encuesta %>%
  mutate(
    activo = case_when(
      activo == "Soy docente de bioarqueología en una universidad pública" ~
        "Si, es mi profesión principal",
      TRUE ~ activo
    )
  )


#--------------------------------------------------------
# 2. EDAD (factor ordenado)
#--------------------------------------------------------

niveles_edad <- c(
  "20 años - 25 años",
  "26 años - 30 años",
  "31 años - 35 años",
  "36 años - 40 años",
  "41 años - 45 años",
  "46 años -50 años",
  "50 años o más"
)

encuesta <- encuesta %>%
  mutate(
    edad = factor(edad, levels = niveles_edad, ordered = TRUE)
  )


#--------------------------------------------------------
# 3. EXPERIENCIA (factor ordenado)
#--------------------------------------------------------

niveles_experiencia <- c(
  "No tengo experiencia",
  "Menos de 1 año",
  "Entre 1 a 3 años",
  "4 a 6 años",
  "7 a 10 años",
  "11 y 15 años"
)

encuesta <- encuesta %>%
  mutate(
    experiencia = factor(experiencia, levels = niveles_experiencia, ordered = TRUE)
  )


#--------------------------------------------------------
# 4. FORMACION (factor ordenado)
#--------------------------------------------------------

niveles_formacion <- c(
  "Estudiante de pregrado",
  "Pregrado",
  "Especializacion",
  "Maestría",
  "Doctorado",
  "Posdoctorado"
)

encuesta <- encuesta %>%
  mutate(
    formacion = factor(formacion, levels = niveles_formacion, ordered = TRUE)
  )


#--------------------------------------------------------
# 5. INGRESO (factor ordenado)
#    "Prefiero no responder" -> NA (no tiene orden numérico)
#--------------------------------------------------------

niveles_ingreso <- c(
  "Nunca he ganado nada",
  "Menos de 2 millones de pesos",
  "De 2 millones a 2.5 millones",
  "De 2.5 millones a 3 millones",
  "De 3 millones a 4 millones",
  "De 4 millones a 5 millones",
  "De 5 millones a 6 millones",
  "6 millones a 7 millones",
  "7 millones a 8 millones",
  "9 millones a 10 millones",
  "Más de 10 millones"
)

encuesta <- encuesta %>%
  mutate(
    ingreso = if_else(ingreso == "Prefiero no responder", NA_character_, ingreso),
    ingreso = factor(ingreso, levels = niveles_ingreso, ordered = TRUE)
  )


#--------------------------------------------------------
# 6. PERSONAS_CARGO (factor ordenado)
#--------------------------------------------------------

niveles_personas_cargo <- c(
  "Ninguna",
  "De 1 a 3 personas",
  "De 4 a 10 personas",
  "Más de 10 personas"
)

encuesta <- encuesta %>%
  mutate(
    personas_cargo = factor(personas_cargo, levels = niveles_personas_cargo, ordered = TRUE)
  )


#--------------------------------------------------------
# 7. REMUNERACION (factor ordenado)
#    "No sé cuánto debería ganar realmente" -> NA
#--------------------------------------------------------

niveles_remuneracion <- c(
  "Mucho menor a la que debería ganar",
  "Algo menor de lo que debería ganar",
  "Aproximadamente lo que debería ganar",
  "Mucho mayor de lo que debería ganar"
)

encuesta <- encuesta %>%
  mutate(
    remuneracion = if_else(
      remuneracion == "No sé cuánto debería ganar realmente",
      NA_character_,
      remuneracion
    ),
    remuneracion = factor(remuneracion, levels = niveles_remuneracion, ordered = TRUE)
  )


#--------------------------------------------------------
# 8. DIAS_CAMPO (recodificar + factor ordenado)
#    "No realizo trabajo de campo" -> "0 días"
#    "Depende del mes" -> NA
#    NaN -> NA
#    Números sueltos y frases ("Todos los días", "3 meses
#    al año", etc.) -> "Más de 15 días"
#--------------------------------------------------------

encuesta <- encuesta %>%
  mutate(
    dias_campo = str_squish(dias_campo),
    dias_campo = case_when(
      dias_campo == "No realizo trabajo de campo" ~ "0 días",
      dias_campo == "Depende del mes" ~ NA_character_,
      dias_campo %in% c(
        "30", "26", "28",
        "Todos los días",
        "3 meses al año",
        "Todo el mes, tengo que estar en obra así no excavemos."
      ) ~ "Más de 15 días",
      TRUE ~ dias_campo
    )
  )

niveles_dias_campo <- c(
  "0 días",
  "De 1 a 5 días",
  "De 6 a 10 días",
  "11 a 15 días",
  "Más de 15 días"
)

encuesta <- encuesta %>%
  mutate(
    dias_campo = factor(dias_campo, levels = niveles_dias_campo, ordered = TRUE)
  )


#--------------------------------------------------------
# 9. POSGRADO_VALIO (recodificar texto libre -> categorías)
#    6 categorías cerradas + 23 respuestas "otro" clasificadas
#--------------------------------------------------------

encuesta <- encuesta %>%
  mutate(
    posgrado_valio_original = posgrado_valio,
    posgrado_valio = str_squish(posgrado_valio),
    posgrado_valio = case_when(
      
      # ---- Categorías cerradas originales ----
      posgrado_valio == "No tengo título de posgrado aún, pero quiero hacerlo" ~
        "No tiene posgrado",
      posgrado_valio == "Útil. Lo mejoró si, pero no lo que esperaba" ~
        "Parcialmente valió la pena",
      posgrado_valio == "Definitivamente. Mejoró mis oportunidades y mi salario" ~
        "Sí valió la pena",
      posgrado_valio == "Poco útil. Muy poco realmente" ~
        "Poco valió la pena",
      posgrado_valio == "Considero que el posgrado no es relevante" ~
        "No relevante / no aplica",
      posgrado_valio == "Para nada. Lo que aprendí no se aplica en mi trabajo. La inversión se perdió" ~
        "No valió la pena",
      
      # ---- Respuestas "otro" (texto libre) clasificadas ----
      posgrado_valio == "No tengo posgrado" ~
        "No tiene posgrado",
      posgrado_valio == "No tengo título de posgrado y no quiero hacerlo" ~
        "No tiene posgrado",
      posgrado_valio == "no me interesa hacer posgrado" ~
        "No tiene posgrado",
      posgrado_valio == "No lo he hecho" ~
        "No tiene posgrado",
      posgrado_valio == "No tengo posgrado en arqueológia en sig" ~
        "No tiene posgrado",
      posgrado_valio == "No tengo posgrado en Arqueología, pero si tienes rna deberías adquirir más habilidades profesionales" ~
        "No tiene posgrado",
      posgrado_valio == "No tengo posgrado, porque los colegas que conozco que si lo tienen han tenido demasiadas dificultades para encontrar trabajo por estar \" sobre perfilados\" o no se les reconoce lo aprendido a nivel económico." ~
        "No tiene posgrado",
      posgrado_valio == "No aplica" ~
        "No tiene posgrado",
      
      posgrado_valio == "Sin maestría no sería profesor pero igual el salario es pobre" ~
        "Parcialmente valió la pena",
      posgrado_valio == "El posgrado es relevante, me dió mucha claridad conceptual y epistemica, sin embargo, actualmente no lo ejecuto formalmente en mi trabajo, soy docente de Política Global." ~
        "Parcialmente valió la pena",
      posgrado_valio == "Solo lo estudié porque era necesario para optimizar mi desempeño profesional" ~
        "Parcialmente valió la pena",
      posgrado_valio == "Lo realice fuera de Colombia, con la intención de aprender y es vergonzoso que en el país se diga haciendo lo mismo, que hace 50 años..." ~
        "Parcialmente valió la pena",
      posgrado_valio == "Mi posgrado no es en arquelogia" ~
        "Parcialmente valió la pena",
      posgrado_valio == "Recién me gradué de la especialización y aún no he podido el impacto del posgrado en mi salario o desarrollo profesional" ~
        "Parcialmente valió la pena",
      
      posgrado_valio == "Vale la pena ser transdisciplinario" ~
        "Sí valió la pena",
      
      posgrado_valio == "la formación académica no.se refleja en los salarios" ~
        "No valió la pena",
      posgrado_valio == "Inicie y no termine. Mala formacion." ~
        "No valió la pena",
      
      posgrado_valio == "Soy maestrante pero no en arqueología." ~
        "En curso / no aplica",
      posgrado_valio == "Estoy haciendo una maestría" ~
        "En curso / no aplica",
      posgrado_valio == "Mi maestría es en patrimonio cultural y estoy terminando" ~
        "En curso / no aplica",
      
      TRUE ~ posgrado_valio
    )
  )

niveles_posgrado_valio <- c(
  "No tiene posgrado",
  "En curso / no aplica",
  "No relevante / no aplica",
  "No valió la pena",
  "Poco valió la pena",
  "Parcialmente valió la pena",
  "Sí valió la pena"
)

encuesta <- encuesta %>%
  mutate(
    posgrado_valio = factor(posgrado_valio, levels = niveles_posgrado_valio, ordered = TRUE)
  )

# Corregir respuestas no pertinentes en genero
generos_validos <- c(
  "Hombre",
  "Mujer",
  "No binario",
  "Prefiero no decirlo"
)

encuesta <- encuesta |>
  mutate(
    genero = if_else(
      genero %in% generos_validos,
      genero,
      "Prefiero no decirlo"
    )
  )
#--------------------------------------------------------
# 10. Verificación rápida: que no queden NA inesperados
#     por errores de escritura no capturados en el case_when
#--------------------------------------------------------

cat("---- Verificación posgrado_valio ----\n")
cat("NA generados:", sum(is.na(encuesta$posgrado_valio)), "\n")
if (sum(is.na(encuesta$posgrado_valio)) > 0) {
  cat("Revisar estos textos originales que no matchearon:\n")
  print(
    encuesta %>%
      filter(is.na(posgrado_valio)) %>%
      select(posgrado_valio_original) %>%
      distinct()
  )
}

encuesta <- encuesta %>% select(-posgrado_valio_original)


#--------------------------------------------------------
# Guardar base final para el dashboard
#--------------------------------------------------------

write_csv(
  encuesta,
  "data/processed/encuesta_dashboard.csv"
)

cat("\nencuesta_dashboard.csv creado correctamente.\n")
cat("Filas:", nrow(encuesta), " Columnas:", ncol(encuesta), "\n")

