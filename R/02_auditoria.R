source("R/00_paquetes.R")

# Leer la encuesta
encuesta <- read_csv(
  "data/raw/encuesta-arqueologia.csv",
  show_col_types = FALSE
)

# Limpiar nombres de variables
encuesta <- clean_names(encuesta)

# Resumen general
glimpse(encuesta)

# Resumen estadístico
skim(encuesta)

# Número de filas y columnas
cat("Número de filas:", nrow(encuesta), "\n")
cat("Número de columnas:", ncol(encuesta), "\n")

# Nombres de variables
names(encuesta)

