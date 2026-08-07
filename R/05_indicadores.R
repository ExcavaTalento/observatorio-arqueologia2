#========================================================
# 05_indicadores.R
# Calcula los KPIs del Observatorio
#========================================================

source("R/00_paquetes.R")

#---------------------------------------
# Leer base lista para dashboard
#---------------------------------------
encuesta <- read_csv(
  "data/processed/encuesta_procesada.csv",
  show_col_types = FALSE
)

#---------------------------------------
# Función para obtener la moda
#---------------------------------------

moda <- function(x){
  
  x <- na.omit(x)
  
  tabla <- table(x)
  
  names(tabla)[which.max(tabla)]
  
}

#---------------------------------------
# KPIs
#---------------------------------------

kpi_total <- nrow(encuesta)

kpi_genero <- moda(encuesta$genero)

kpi_formacion <- moda(encuesta$formacion)

kpi_ingreso <- moda(encuesta$ingreso)

kpi_experiencia <- moda(encuesta$experiencia)

kpi_departamentos <- n_distinct(encuesta$departamento)

#---------------------------------------
# Mostrar resultados
#---------------------------------------

cat("\n")
cat("=========== KPIs ===========\n\n")

cat("Participantes:", kpi_total,"\n")

cat("Género predominante:",kpi_genero,"\n")

cat("Formación predominante:",kpi_formacion,"\n")

cat("Ingreso predominante:",kpi_ingreso,"\n")

cat("Experiencia predominante:",kpi_experiencia,"\n")

cat("Departamentos representados:",kpi_departamentos,"\n")

moda <- function(x){
  
  x <- na.omit(x)
  
  tabla <- table(x)
  
  names(tabla)[which.max(tabla)]
  
}

kpis <- tibble(
  
  indicador = c(
    "Participantes",
    "Genero predominante",
    "Formacion predominante",
    "Ingreso predominante",
    "Experiencia predominante",
    "Departamentos representados"
  ),
  
  valor = c(
    kpi_total,
    kpi_genero,
    kpi_formacion,
    kpi_ingreso,
    kpi_experiencia,
    kpi_departamentos
  )
  
)


write_csv(
  kpis,
  "data/processed/kpis.csv"
)

