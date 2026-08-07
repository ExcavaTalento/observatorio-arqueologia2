#========================================================
# 07_graficos.R
# Prepara los datos para los graficos interactivos
#========================================================

source("R/00_paquetes.R")

#--------------------------------------------------------
# Leer tablas
#--------------------------------------------------------

frecuencia_activo <- read_csv(
  "data/processed/frecuencia_activo.csv",
  show_col_types = FALSE
)

frecuencia_genero <- read_csv(
  "data/processed/frecuencia_genero.csv",
  show_col_types = FALSE
)

frecuencia_edad <- read_csv(
  "data/processed/frecuencia_edad.csv",
  show_col_types = FALSE
)

frecuencia_experiencia <- read_csv(
  "data/processed/frecuencia_experiencia.csv",
  show_col_types = FALSE
)

frecuencia_formacion <- read_csv(
  "data/processed/frecuencia_formacion.csv",
  show_col_types = FALSE
)

frecuencia_ingreso <- read_csv(
  "data/processed/frecuencia_ingreso.csv",
  show_col_types = FALSE
)

frecuencia_departamentos <- read_csv(
  "data/processed/frecuencia_departamentos.csv",
  show_col_types = FALSE
)

#--------------------------------------------------------
# Preparar datos
#--------------------------------------------------------

preparar <- function(tabla){
  
  tabla |>
    mutate(
      porcentaje = round(porcentaje,1)
    )
  
}

grafico_activo <- preparar(frecuencia_activo)

grafico_genero <- preparar(frecuencia_genero)

grafico_edad <- preparar(frecuencia_edad)

grafico_experiencia <- preparar(frecuencia_experiencia)

grafico_formacion <- preparar(frecuencia_formacion)

grafico_ingreso <- preparar(frecuencia_ingreso)

grafico_departamentos <- preparar(frecuencia_departamentos)

#--------------------------------------------------------
# Guardar
#--------------------------------------------------------

write_csv(
  grafico_activo,
  "data/processed/grafico_activo.csv"
)

write_csv(
  grafico_genero,
  "data/processed/grafico_genero.csv"
)

write_csv(
  grafico_edad,
  "data/processed/grafico_edad.csv"
)

write_csv(
  grafico_experiencia,
  "data/processed/grafico_experiencia.csv"
)

write_csv(
  grafico_formacion,
  "data/processed/grafico_formacion.csv"
)

write_csv(
  grafico_ingreso,
  "data/processed/grafico_ingreso.csv"
)

write_csv(
  grafico_departamentos,
  "data/processed/grafico_departamentos.csv"
)

cat("\n=====================================\n")
cat("Datos para graficos generados\n")
cat("=====================================\n")

