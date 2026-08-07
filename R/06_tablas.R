#========================================================
# 06_tablas.R
# Genera tablas de frecuencias para el dashboard
#========================================================

source("R/00_paquetes.R")

#--------------------------------------------------------
# Leer base
#--------------------------------------------------------

encuesta <- read_csv(
  "data/processed/encuesta_dashboard.csv",
  show_col_types = FALSE
)

#--------------------------------------------------------
# Función de frecuencias
#--------------------------------------------------------

tabla_frecuencia <- function(datos, variable){
  
  datos |>
    count({{ variable }}, name = "n") |>
    mutate(
      porcentaje = round(n / sum(n) * 100, 1)
    ) |>
    arrange(desc(n))
  
}

#--------------------------------------------------------
# Generar tablas
#--------------------------------------------------------

frecuencia_activo <- tabla_frecuencia(encuesta, activo)

frecuencia_genero <- tabla_frecuencia(encuesta, genero)

frecuencia_edad <- tabla_frecuencia(encuesta, edad)

frecuencia_experiencia <- tabla_frecuencia(encuesta, experiencia)

frecuencia_formacion <- tabla_frecuencia(encuesta, formacion)

frecuencia_ingreso <- tabla_frecuencia(encuesta, ingreso)

#--------------------------------------------------------
# Guardar archivos
#--------------------------------------------------------

write_csv(
  frecuencia_activo,
  "data/processed/frecuencia_activo.csv"
)

write_csv(
  frecuencia_genero,
  "data/processed/frecuencia_genero.csv"
)

write_csv(
  frecuencia_edad,
  "data/processed/frecuencia_edad.csv"
)

write_csv(
  frecuencia_experiencia,
  "data/processed/frecuencia_experiencia.csv"
)

write_csv(
  frecuencia_formacion,
  "data/processed/frecuencia_formacion.csv"
)

write_csv(
  frecuencia_ingreso,
  "data/processed/frecuencia_ingreso.csv"
)

cat("\n=====================================\n")
cat("Tablas generadas correctamente\n")
cat("=====================================\n")


#--------------------------------------------------------
# Verificacion
#--------------------------------------------------------

cat("\n=========================================\n")
cat("Tablas de frecuencias generadas\n")
cat("=========================================\n\n")

list.files(
  "data/processed",
  pattern = "^frecuencia.*\\.csv$"
)
