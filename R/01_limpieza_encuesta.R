#========================================================
# 01_limpieza_encuesta.R
# Limpieza encuesta mercado laboral arqueología
#========================================================

source("R/00_paquetes.R")

#--------------------------------------------------------
# Cargar datos originales
#--------------------------------------------------------

encuesta <- read_csv(
  "data/raw/encuesta-original.csv",
  show_col_types = FALSE
)


#--------------------------------------------------------
# Renombrar variables principales de la encuesta
#--------------------------------------------------------

#========================================================
# Renombrar variables
#========================================================

encuesta_limpia <- encuesta |>
  rename(
    
    activo = `1. Actualmente ¿trabajas en arqueología? \n`,
    
    genero = `2. ¿Con que género te identificas?`,
    
    edad = `3. ¿En qué rango de edad te encuentras?`,
    
    area_arqueologia = `4. ¿En cuál de las siguientes áreas has desarrollado principalmente tu trabajo?`,
    
    fuente_ingresos = `5. Actualmente, ¿cómo obtienes tus ingresos relacionados con arqueología? Puedes seleccionar varias opciones`,
    
    tiempo_experiencia = `6 ¿Cuántos años tienes de experiencia en Arqueología?`,
    
    formacion_academica = `7. ¿Cuál es tu nivel de formación académica?\n`,
    
    salario = `8. ¿Cuál es tu ingreso mensual promedio relacionado con la arqueología?  Si tienes varias fuentes, un promedio general`,
    
    departamento = `9. ¿En qué departamento realizas la mayor parte de tu trabajo? Si tienes varios, elige los 2 más significativos. También aplica trabajo académico`,
    
    factor_ingreso = `10. En tu experiencia, ¿qué factor ha tenido mayor impacto en tus ingresos como arqueólog@?  Lo que mas te ha ayudado a subir tu salario considerablemente`,
    
    cargo = `11. ¿Cuál es actualmente tu cargo o rol en arqueología?`,
    
    sector_mercado = `12. ¿En qué tipo de proyecto o empresa trabajas principalmente?  Si tienes varios, elige el más importante`,
    
    estabilidad_ingreso = `13.Tus ingresos en arqueología son...`,
    
    dias_campo = `14. En un mes típico, ¿cuántos días realizas trabajo de campo?`,
    
    personas_cargo = `15. ¿Cuántas personas tienes a cargo dentro de tu proyecto o empleo?`,
    
    tecnologia = `16. ¿Cuáles de herramientas tecnológicas utilizas más para tus trabajos en arqueología? Elige todas las que sepas manejar`,
    
    problema_laboral = `17. ¿En que grado, consideras tú que es el mayor problema del mercado laboral de la Arqueología en Colombia? Elige el que consideras más relevante`,
    
    valor_posgrado = `18. ¿Valió la pena para ti hacer posgrado en arqueología? A nivel de salario y desarrollo profesional`,
    
    area_posgrado = `19. ¿En qué área está tu posgrado? Especialización, maestría o doctorado. Elige solo una`,
    
    percepcion_remuneracion = `20. Según tu experiencia y lo que notas, ¿crees que tu remuneración actual es..?`,
    
    solucion_profesion = `21. Si pudieras cambiar una sola cosa para mejorar la profesión de los arqueólogos en Colombia, ¿cuál sería?`
  )


# Agregar pregunta 22 por posición
encuesta_limpia$volveria_elegir <- encuesta[[22]]

encuesta_limpia <- encuesta_limpia |>
  select(
    -`22.  Si pudieras decidir de nuevo, ¿volverías a elegir arqueología en Colombia como profesión? Califica de 1 a 5\n\n1. No\n2. Probablemente no\n3. Quizás...Tal vez\n4. Probablemente si\n5. Claro ¡Me encanta!`,
    -`Comentarios y sugerencias que nos quieras hacer o compartir. Puedes dejarnos reflexiones y anécdotas sobre tu vida profesional. Queremos escucharte`
  )



names(encuesta_limpia)

