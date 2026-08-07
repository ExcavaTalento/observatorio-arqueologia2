library(readr)
library(dplyr)

# Leer la encuesta
encuesta <- read_csv("data/raw/encuesta-arqueologia.csv")

library(readr)
library(dplyr)
library(openxlsx)

install.packages("readr")


source("R/00_paquetes.R")

encuesta <- read_csv(
  "data/raw/encuesta-arqueologia.csv",
  show_col_types = FALSE
)

glimpse(encuesta)


# Crear el diccionario
diccionario <- tibble(
  Nombre_variable = names(encuesta),
  Nombre_amigable = "",
  Descripcion = "",
  Tipo = sapply(encuesta, class),
  Categoria = "",
  Respuesta_multiple = "",
  Filtro = "",
  KPI = "",
  Visualizacion = "",
  Observaciones = ""
)

