source("R/00_paquetes.R")

# ==========================
# Importar datos
# ==========================

encuesta <- read_csv(
  "data/raw/encuesta-arqueologia.csv",
  show_col_types = FALSE
)

encuesta <- clean_names(encuesta)

# ==========================
# KPI 1
# ==========================

kpi_total <- nrow(encuesta)

cat("Total de participantes:", kpi_total)

names(encuesta)
