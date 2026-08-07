#========================================================
# 00_paquetes.R
# Paquetes generales del proyecto
#========================================================

paquetes <- c(
  "tidyverse",
  "readr",
  "dplyr",
  "stringr",
  "janitor",
  "lubridate"
)

instalar <- paquetes[
  !(paquetes %in% installed.packages()[,"Package"])
]

if(length(instalar) > 0){
  install.packages(instalar)
}

lapply(
  paquetes,
  library,
  character.only = TRUE
)

