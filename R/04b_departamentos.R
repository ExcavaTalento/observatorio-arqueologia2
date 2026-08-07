#========================================================
# 04b_departamentos.R
# Normalización territorial encuesta arqueología
#========================================================

source("R/00_paquetes.R")


#--------------------------------------------------------
# Leer archivos
#--------------------------------------------------------

encuesta <- read_csv(
  "data/processed/encuesta_procesada.csv",
  show_col_types = FALSE
)


departamentos_oficiales <- read_csv(
  "metadata/departamentos_colombia.csv",
  show_col_types = FALSE
)


equivalencias <- read_csv(
  "metadata/equivalencias_departamentos.csv",
  show_col_types = FALSE
)



#--------------------------------------------------------
# Separar respuestas múltiples
#--------------------------------------------------------

departamentos_encuesta <- encuesta %>%
  
  mutate(
    id_respuesta = row_number()
  ) %>%
  
  select(
    id_respuesta,
    departamento
  ) %>%
  
  separate_rows(
    departamento,
    sep = ","
  ) %>%
  
  mutate(
    departamento = str_trim(departamento),
    departamento = iconv(departamento, from = "UTF-8", to = "ASCII//TRANSLIT")
  )



#--------------------------------------------------------
# Aplicar equivalencias
# (nota: si tu tabla equivalencias.csv tiene tildes en
#  nombre_encuesta, esas filas ya no harán match porque
#  departamento ya quedó sin tildes arriba. Por eso también
#  normalizamos nombre_encuesta aquí, para que el join
#  funcione sin importar cómo esté escrito el csv)
#--------------------------------------------------------

equivalencias <- equivalencias %>%
  mutate(
    nombre_encuesta = iconv(nombre_encuesta, from = "UTF-8", to = "ASCII//TRANSLIT")
  ) %>%
  distinct(nombre_encuesta, .keep_all = TRUE)

departamentos_encuesta <- departamentos_encuesta %>%
  
  left_join(
    equivalencias,
    by = c(
      "departamento" = "nombre_encuesta"
    )
  ) %>%
  
  mutate(
    departamento = if_else(
      is.na(nombre_oficial),
      departamento,
      nombre_oficial
    )
  ) %>%
  
  select(
    id_respuesta,
    departamento
  )



#--------------------------------------------------------
# Separar Colombia (32 departamentos + Bogotá D.C. = 33)
# de otros lugares (México, "Donde se presente...")
#--------------------------------------------------------

encuesta_departamentos <- departamentos_encuesta %>%
  
  filter(
    departamento %in%
      departamentos_oficiales$departamento
  )


otros_lugares <- departamentos_encuesta %>%
  
  filter(
    !departamento %in%
      departamentos_oficiales$departamento
  )



#--------------------------------------------------------
# Frecuencia territorial (33 filas, con ceros incluidos)
#--------------------------------------------------------

frecuencia_departamentos <- departamentos_oficiales %>%
  
  left_join(
    encuesta_departamentos %>% count(departamento),
    by = "departamento"
  ) %>%
  
  mutate(
    n = ifelse(is.na(n), 0, n)
  )



#--------------------------------------------------------
# Guardar resultados
#--------------------------------------------------------

write_csv(
  encuesta_departamentos,
  "data/processed/encuesta_departamentos.csv"
)


write_csv(
  otros_lugares,
  "data/processed/otros_lugares.csv"
)


write_csv(
  frecuencia_departamentos,
  "data/processed/frecuencia_departamentos.csv"
)



#--------------------------------------------------------
# Auditoría
#--------------------------------------------------------

cat("\nProceso territorial terminado\n")

cat(
  "Territorios encontrados:",
  n_distinct(encuesta_departamentos$departamento),
  "de 33 (32 departamentos + Bogota D.C.)\n"
)

cat(
  "Otros registros (deben ser solo Mexico / 'Donde se presente...'):",
  nrow(otros_lugares),
  "\n"
)

cat(
  "Check de cuadre -> suma frecuencia_departamentos:",
  sum(frecuencia_departamentos$n),
  "== filas encuesta_departamentos:",
  nrow(encuesta_departamentos),
  "\n"
)

print(otros_lugares %>% count(departamento))


