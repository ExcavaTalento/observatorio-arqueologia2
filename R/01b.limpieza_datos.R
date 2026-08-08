
#______________________________________________________________________________
#Genero

unique(encuesta_limpia$genero)

#cambiar datos
encuesta_limpia <- encuesta_limpia |>
  mutate(
    genero = case_when(
      genero %in% c(
        "Hombre",
        "Mujer",
        "Trans",
        "Genero no binario",
        "Prefiero no decirlo"
      ) ~ genero,
      TRUE ~ "Prefiero no decirlo"
    )
  )

#verificar que quedo bien
table(encuesta_limpia$genero)

#______________________________________________________________________________
#Edad

unique(encuesta_limpia$edad)

#normalizacion de edad

encuesta_limpia <- encuesta_limpia |>
  mutate(
    edad = case_when(
      edad == "46 años -50 años" ~ "46 años - 50 años",
      TRUE ~ edad
    )
  )

#ordenamiento de los datos
encuesta_limpia <- encuesta_limpia |>
  mutate(
    edad = case_when(
      edad == "46 años -50 años" ~ "46 años - 50 años",
      TRUE ~ edad
    ),
    edad = factor(
      edad,
      levels = c(
        "20 años - 25 años",
        "26 años - 30 años",
        "31 años - 35 años",
        "36 años - 40 años",
        "41 años - 45 años",
        "46 años - 50 años",
        "50 años o más"
      ),
      ordered = TRUE
    )
  )
levels(encuesta_limpia$edad)

table(encuesta_limpia$edad, useNA = "ifany")

#______________________________________________________________________________
#tiempo_experiencia

unique(encuesta_limpia$tiempo_experiencia)

encuesta_limpia$tiempo_experiencia <- factor(
  encuesta_limpia$tiempo_experiencia,
  levels = c(
    "No tengo experiencia",
    "Menos de 1 año",
    "Entre 1 a 3 años",
    "4 a 6 años",
    "7 a 10 años",
    "11 y 15 años"
    
  ),
  ordered = TRUE
)

table(encuesta_limpia$tiempo_experiencia, useNA = "ifany")

table(encuesta_limpia$tiempo_experiencia)

#______________________________________________________________________________
#formacion_academica

unique(encuesta_limpia$formacion_academica)

table(encuesta_limpia$formacion_academica, useNA = "ifany")

#______________________________________________________________________________
#salario

unique(encuesta_limpia$salario)

table(encuesta_limpia$salario, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    salario = factor(
      salario,
      levels = c(
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
        "Más de 10 millones",
        "Prefiero no responder"
      ),
      ordered = TRUE
    )
  )

levels(encuesta_limpia$salario)

table(encuesta_limpia$salario, useNA = "ifany")

#______________________________________________________________________________
#departamento

library(dplyr)
library(tidyr)
library(stringr)

unique(encuesta_limpia$departamento)

table(
  encuesta_limpia$departamento,
  useNA = "ifany"
)

encuesta_limpia <- encuesta_limpia |>
  mutate(
    departamento = str_replace_all(departamento, "Atlánico", "Atlantico"),
    departamento = str_replace_all(departamento, "Antioquía", "Antioquia"),
    departamento = str_replace_all(departamento, "Bogotá D.C.", "Bogota D.C."),
    departamento = str_replace_all(departamento, "Chocó", "Choco"),
    departamento = str_replace_all(departamento, "Boyacá", "Boyaca"),
    departamento = str_replace_all(departamento, "Nariño", "Narino"),
    departamento = str_replace_all(
      departamento,
      "San Andrés, Providencia y Santa Catalina",
      "San Andres, Providencia y Santa Catalina"
    ),
    departamento = str_replace_all(departamento, "Á", "A"),
    departamento = str_replace_all(departamento, "É", "E"),
    departamento = str_replace_all(departamento, "Í", "I"),
    departamento = str_replace_all(departamento, "Ó", "O"),
    departamento = str_replace_all(departamento, "Ú", "U"),
    departamento = str_replace_all(departamento, "á", "a"),
    departamento = str_replace_all(departamento, "é", "e"),
    departamento = str_replace_all(departamento, "í", "i"),
    departamento = str_replace_all(departamento, "ó", "o"),
    departamento = str_replace_all(departamento, "ú", "u"),
    departamento = str_replace_all(departamento, "Ñ", "N"),
    departamento = str_replace_all(departamento, "ñ", "n")
  )

grep(
  "[áéíóúÁÉÍÓÚñÑ]",
  unique(encuesta_limpia$departamento),
  value = TRUE
)

encuesta_departamentos <- encuesta_limpia |>
  mutate(
    id_respuesta = row_number()
  ) |>
  separate_rows(
    departamento,
    sep = ","
  ) |>
  mutate(
    departamento = str_trim(departamento)
  )

table(
  encuesta_departamentos$departamento,
  useNA = "ifany"
)

encuesta_departamentos <- encuesta_departamentos |>
  mutate(
    tipo_lugar = if_else(
      departamento %in% c(
        "Donde se presente la oportunidad",
        "Mexico"
      ),
      "Otros",
      "Departamento"
    )
  )

frecuencia_departamentos <- encuesta_departamentos |>
  filter(
    tipo_lugar == "Departamento"
  ) |>
  count(
    departamento,
    name = "n"
  ) |>
  arrange(desc(n))

otros_lugares <- encuesta_departamentos |>
  filter(
    tipo_lugar == "Otros"
  )

sort(
  table(encuesta_departamentos$departamento),
  decreasing = TRUE
)

frecuencia_departamentos

otros_lugares

write_csv(
  encuesta_departamentos,
  "data/processed/encuesta_departamentos.csv"
)

write_csv(
  frecuencia_departamentos,
  "data/processed/frecuencia_departamentos.csv"
)

write_csv(
  otros_lugares,
  "data/processed/otros_lugares.csv"
)
#______________________________________________________________________________
#factor_ingreso

unique(encuesta_limpia$factor_ingreso)

table(encuesta_limpia$factor_ingreso, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    factor_ingreso = case_when(
      factor_ingreso == "Años de experiencia" ~ "Años de experiencia",
      factor_ingreso == "Manejar SIG" ~ "Manejo de SIG",
      factor_ingreso == "Tener RNA" ~ "Tener RNA",
      factor_ingreso %in% c(
        "Tus buenos contactos y tu red profesional",
        "Rosca",
        "Palanca"
      ) ~ "Red de contactos",
      factor_ingreso == "Ubicacion geográfica" ~ "Ubicacion geografica",
      factor_ingreso == "Redes sociales" ~ "Redes sociales",
      factor_ingreso %in% c(
        "Nivel de formacion academica (especializacion, maestria, doctorado)",
        "conocer como se hace la arqueología histórica en colombia"
      ) ~ "Formacion academica",
      factor_ingreso %in% c(
        "Habilidades tecnológicas: programación, Excel, analitica de datos, bases de datos, etc",
        "Acá se debería tener opción de respuesta múltiple. En mi caso SIG, bases de datos, analitica de datos, gesrion y coordinacion de proyetos",
        "Años de experiencia, Manejar DIG, Tener RNA, Habilidades tecnológicas: programación, Excel, analítica de datos, bases de datos, etc."
      ) ~ "Habilidades tecnologicas",
      factor_ingreso %in% c(
        "Conocimientos especializados en zooarqueología, bioarqueología o afines",
        "Tu especialidad técnica en arqueología: cerámica, líticos, etc"
      ) ~ "Especializacion tecnica",
      factor_ingreso == "Tener una marca personal reconocida" ~ "Marca personal",
      factor_ingreso %in% c(
        "Habilidades de comunicación y persuasión",
        "Coordinador de actividades"
      ) ~ "Comunicacion y persuasion",
      factor_ingreso == "Producción de artículos, libros, etc" ~ "Produccion academica",
      factor_ingreso == "Saber matemáticas y estadística" ~ "Matematicas y estadistica",
      factor_ingreso == "Saber bucear" ~ "Otra habilidad tecnica",
      factor_ingreso %in% c(
        "Sector hidrocarburos",
        "Sector hidrocarburos por tener conocimiento de suelos, geología o afines"
      ) ~ "Conocimiento de suelos y geologia",
      factor_ingreso %in% c(
        "Nada ha ayudado a tener mejores ingresos",
        "Nada ha mejorado mis ingresos",
        "Ninguno se tiene en cuenta",
        "Aún no ha subido considerablemente",
        "En realidad es un área donde las posibilidades de subir el sueldo son muy limitadas a pesar de cualquier conocimiento específico.",
        "No he aumentado el sueldo considerablemente a pesar de tener más experiencia y por ende más conocimiento,empecé en 2015 con salario de 3000000 y hoy apenas alcance los 4 000000"
      ) ~ "Ninguno",
      factor_ingreso %in% c(
        "Crear buen contenido",
        "Calidad y responsabilidad en el trabajo.",
        "Casualidad"
      ) ~ "Otro",
      TRUE ~ factor_ingreso
    )
  )

table(encuesta_limpia$factor_ingreso, useNA = "ifany")

#______________________________________________________________________________
#cargo

unique(encuesta_limpia$cargo)

table(encuesta_limpia$cargo, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    cargo = case_when(
      cargo == "Arqueólogo" ~ "Arqueologo",
      cargo == "Auxiliar de arqueología" ~ "Auxiliar de arqueologia",
      cargo == "Coordinador de proyectos o afines" ~ "Coordinador de proyectos",
      cargo == "Director o lider de proyecto" ~ "Director o lider de proyecto",
      cargo %in% c(
        "Profesor de antropología, arqueología o afines",
        "Profesor, director - coordinador proyectos, investigador"
      ) ~ "Profesor o docente",
      cargo == "Investigador independiente" ~ "Investigador independiente",
      cargo == "Consultor" ~ "Consultor",
      cargo == "Gestor social o cultural" ~ "Gestor social o cultural",
      cargo == "Empresario o emprendedor" ~ "Empresario o emprendedor",
      cargo == "Semillerista - Estudiante" ~ "Semillerista o estudiante",
      cargo %in% c(
        "Antropologo Forense",
        "Antropóloga forense"
      ) ~ "Antropologo forense",
      cargo == "Analista" ~ "Analista",
      cargo == "Profesional Residente de obra" ~ "Profesional residente de obra",
      cargo == "Tallerista" ~ "Tallerista",
      cargo %in% c(
        "Desempleado",
        "Desempleada",
        "desempleada"
      ) ~ "Desempleado",
      TRUE ~ cargo
    )
  )

table(encuesta_limpia$cargo, useNA = "ifany")

#______________________________________________________________________________
#sector_mercado

unique(encuesta_limpia$sector_mercado)

encuesta_limpia <- encuesta_limpia |>
  mutate(
    sector_mercado = case_when(
      
      sector_mercado == "Consultoría ambiental o estudios de impacto" ~
        "Consultoria ambiental o estudios de impacto",
      
      sector_mercado == "Empresas petroleras o de extracción de gas" ~
        "Oil and Gas",
      
      sector_mercado == "Escuelas o colegios" ~
        "Escuelas o colegios",
      
      sector_mercado == "Gestión del patrimonio cultural" ~
        "Patrimonio cultural",
      
      sector_mercado %in% c(
        "ICANH",
        "Instituciones gubernamentales"
      ) ~
        "Instituciones gubernamentales",
      
      sector_mercado == "Obras civiles: empresas dedicadas a la construcción de carreteras, urbanismo, energía, construcción" ~
        "Obras civiles y construccion",
      
      sector_mercado == "Parques foltovoltáicos. Sector energético" ~
        "Sector energetico",
      
      sector_mercado == "Sector forense - Fiscalía - UBPD" ~
        "Sector forense",
      
      sector_mercado == "Semillerista de investigación - Universidad" ~
        "Semillerista de investigacion",
      
      sector_mercado == "Soy empresario, emprendedor" ~
        "Empresario o emprendedor",
      
      sector_mercado == "Trabajo en laboratorios" ~
        "Laboratorios",
      
      sector_mercado == "Trabajo independiente, freenlance o por proyectos" ~
        "Trabajo independiente o por proyectos",
      
      sector_mercado == "Universidad" ~
        "Universidad",
      
      sector_mercado == "Voluntariado" ~
        "Voluntariado",
      
      TRUE ~ sector_mercado
    )
  )

unique(encuesta_limpia$sector_mercado)

table(encuesta_limpia$sector_mercado, useNA = "ifany")

#_____________________________________________________________________________
#estabilidad_ingreso

unique(encuesta_limpia$estabilidad_ingreso)

table(encuesta_limpia$estabilidad_ingreso, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    estabilidad_ingreso = case_when(
      estabilidad_ingreso == "Muy estables. Cuento siempre con un salario fijo" ~
        "Muy estables",
      
      estabilidad_ingreso == "Variables. Depende de contratos" ~
        "Variables. Dependen de contratos",
      
      estabilidad_ingreso == "Ocasionales o esporádicos" ~
        "Ocasionales o esporadicos",
      
      estabilidad_ingreso == "Un poco fijos. Dependen de mis ingresos generados por consultoría o creación de contenido" ~
        "Un poco fijos. Dependen de consultoria o creacion de contenido",
      
      estabilidad_ingreso == "Ninguno" ~
        "Ninguno",
      
      TRUE ~ estabilidad_ingreso
    )
  )

table(encuesta_limpia$estabilidad_ingreso, useNA = "ifany")

#_____________________________________________________________________________
#dias_campo

unique(encuesta_limpia$dias_campo)

table(encuesta_limpia$dias_campo, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    dias_campo = case_when(
      is.na(dias_campo) ~ "No realizo trabajo de campo",
      dias_campo == "3 meses al año" ~ "Más de 15 días",
      dias_campo == "Depende del mes" ~ "No definido",
      dias_campo == "Todo el mes, tengo que estar en obra así no excavemos." ~ "Más de 15 días",
      dias_campo == "Todos los días" ~ "Más de 15 días",
      dias_campo %in% c("26", "28", "30") ~ "Más de 15 días",
      TRUE ~ dias_campo
    )
  )

unique(encuesta_limpia$dias_campo)

table(encuesta_limpia$dias_campo, useNA = "ifany")

#_____________________________________________________________________________
#personas_cargo

unique(encuesta_limpia$personas_cargo)

table(encuesta_limpia$personas_cargo, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    personas_cargo = replace_na(personas_cargo, "Ninguna")
  )


table(encuesta_limpia$personas_cargo, useNA = "ifany")

#_____________________________________________________________________________
#tecnologia

unique(encuesta_limpia$tecnologia)

table(encuesta_limpia$tecnologia, useNA = "ifany")

#tabla independiente

# ========================================================
# NORMALIZACION DE TECNOLOGIAS
# ========================================================

library(dplyr)
library(stringr)
library(tidyr)

tecnologias <- encuesta_limpia |>
  select(tecnologia) |>
  mutate(
    tecnologia = str_replace_all(tecnologia, "Agisfot", "Agisoft"),
    tecnologia = str_replace_all(tecnologia, "Citacion bibliográfica", "Gestion bibliografica"),
    tecnologia = str_replace_all(tecnologia, "Software de creación 3D: Blender, Agisoft Metashape, SketchUp, etc", "Software 3D"),
    tecnologia = str_replace_all(tecnologia, "Software de dibujo técnico y edicion fotografica: Illustrator, Corel, Krita, etc", "Diseno grafico y edicion fotografica"),
    tecnologia = str_replace_all(tecnologia, "Redes sociales: WhatsApp, Telegram, etc", "Redes sociales"),
    tecnologia = str_replace_all(tecnologia, "Avenza maps y kobocollect", "Avenza Maps / KoboCollect"),
    tecnologia = str_replace_all(tecnologia, "BASECAMP", "Basecamp"),
    tecnologia = str_replace_all(tecnologia, "SURFER", "Surfer")
  ) |>
  separate_rows(tecnologia, sep = ",\\s*") |>
  mutate(
    tecnologia = str_trim(tecnologia)
  )

tecnologias <- tecnologias |>
  mutate(
    tecnologia = case_when(
      
      # Gestion bibliografica
      tecnologia %in% c(
        "EndNote",
        "Zotero",
        "Gestion bibliografica: Mendeley",
        "Mendeley"
      ) ~ "Gestion bibliografica",
      
      # Avenza Maps
      tecnologia %in% c(
        "avenza",
        "Avenza Maps",
        "Avenza Maps / KoboCollect"
      ) ~ "Avenza Maps",
      
      # KoboCollect
      tecnologia %in% c(
        "Kobo",
        "KoboCollect"
      ) ~ "KoboCollect",
      
      # Normalizacion de nombres
      tecnologia == "qfield" ~ "QField",
      tecnologia == "QGis" ~ "QGIS",
      tecnologia == "ArcGis" ~ "ArcGIS",
      
      # Eliminar fragmento no util
      tecnologia == "etc" ~ NA_character_,
      
      TRUE ~ tecnologia
    )
  ) |>
  filter(!is.na(tecnologia))

table(tecnologias$tecnologia, useNA = "ifany")

#_____________________________________________________________________________
#problema_laboral

unique(encuesta_limpia$problema_laboral)

table(encuesta_limpia$problema_laboral, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    problema_laboral = case_when(
      problema_laboral == "Bajos salarios" ~ "Bajos salarios",
      problema_laboral == "Falta de relación entre formación y oportunidades laborales" ~ "Desconexion entre formacion y oportunidades",
      problema_laboral == "Falta de estabilidad laboral" ~ "Falta de estabilidad laboral",
      problema_laboral == "Falta de claridad en tarifas u honorarios" ~ "Falta de claridad en tarifas",
      problema_laboral == "Exceso de informalidad" ~ "Exceso de informalidad",
      problema_laboral == "Diferencias marcadas entre sectores (académico vs obras civiles)" ~ "Diferencias entre sectores",
      problema_laboral == "La información es muy dispersa" ~ "Informacion laboral dispersa",
      problema_laboral == "Otro" ~ "Otro",
      problema_laboral == "Poca oferta de empleos" ~ "Poca oferta de empleos",
      problema_laboral == "Falta de reconocimiento profesional" ~ "Falta de reconocimiento profesional",
      TRUE ~ problema_laboral
    )
  )
table(encuesta_limpia$problema_laboral, useNA = "ifany")

#_____________________________________________________________________________
#valor_posgrado

unique(encuesta_limpia$valor_posgrado)

valor_posgrado_original <- encuesta_limpia$valor_posgrado

table(valor_posgrado_original, useNA = "ifany")

encuesta_limpia <- encuesta_limpia |>
  mutate(
    valor_posgrado = case_when(
      valor_posgrado_original %in% c(
        "No tengo título de posgrado aún, pero quiero hacerlo"
      ) ~ "No tengo posgrado, pero quiero hacerlo",
      
      valor_posgrado_original %in% c(
        "No tengo título de posgrado y no quiero hacerlo",
        "no me interesa hacer posgrado"
      ) ~ "No tengo posgrado y no quiero hacerlo",
      
      valor_posgrado_original %in% c(
        "No tengo posgrado",
        "No tengo posgrado en arqueológia en sig",
        "No tengo posgrado en Arqueología, pero si tienes rna deberías adquirir más habilidades profesionales",
        "No aplica",
        "No lo he hecho",
        "Inicie y no termine. Mala formacion."
      ) ~ "No tengo posgrado",
      
      valor_posgrado_original %in% c(
        "Definitivamente. Mejoró mis oportunidades y mi salario"
      ) ~ "Mejoró oportunidades e ingresos",
      
      valor_posgrado_original %in% c(
        "Útil. Lo mejoró si, pero no lo que esperaba",
        "Recién me gradué de la especialización y aún no he podido el impacto del posgrado en mi salario o desarrollo profesional",
        "Sin maestría no sería profesor pero igual el salario es pobre"
      ) ~ "Mejoró parcialmente",
      
      valor_posgrado_original %in% c(
        "Considero que el posgrado no es relevante",
        "Poco útil. Muy poco realmente",
        "Para nada. Lo que aprendí no se aplica en mi trabajo. La inversión se perdió",
        "la formación académica no.se refleja en los salarios",
        "No tengo posgrado, porque los colegas que conozco que si lo tienen han tenido demasiadas dificultades para encontrar trabajo por estar \" sobre perfilados\" o no se les reconoce lo aprendido a nivel económico."
      ) ~ "No mejoró oportunidades e ingresos",
      
      valor_posgrado_original %in% c(
        "Solo lo estudié porque era necesario para optimizar mi desempeño profesional",
        "El posgrado es relevante, me dió mucha claridad conceptual y epistemica, sin embargo, actualmente no lo ejecuto formalmente en mi trabajo, soy docente de Política Global.",
        "Vale la pena ser transdisciplinario",
        "Lo realice fuera de Colombia, con la intención de aprender y es vergonzoso que en el país se diga haciendo lo mismo, que hace 50 años...",
        "Soy maestrante pero no en arqueología.",
        "Mi posgrado no es en arquelogia",
        "Mi maestría es en patrimonio cultural y estoy terminando"
      ) ~ "Mejoró solo el perfil profesional",
      
      valor_posgrado_original == "Estoy haciendo una maestría" ~
        "No tengo posgrado, pero quiero hacerlo",
      
      TRUE ~ NA_character_
    )
  )

table(
  encuesta_limpia$valor_posgrado,
  useNA = "ifany"
)

sum(
  table(
    encuesta_limpia$valor_posgrado,
    useNA = "ifany"
  )
)
#_____________________________________________________________________________
#area_posgrado

unique(encuesta_limpia$area_posgrado)

table(
  encuesta_limpia$area_posgrado,
  useNA = "ifany"
)

encuesta_limpia <- encuesta_limpia |>
  mutate(
    area_posgrado = case_when(
      
      area_posgrado_original == "No tengo posgrado" ~
        "No tengo posgrado",
      
      area_posgrado_original == "Antropología en general o arqueología" ~
        "Antropología y Arqueología",
      
      area_posgrado_original == "Arqueometría. Ciencias de datos. Ingeniería de sistemas. Analítica de datos. Inteligencia artificial" ~
        "Arqueometría",
      
      area_posgrado_original == "Derecho. Antropología forense. Arqueología forense. Derechos humanos, enfocado al tema forense." ~
        "Derecho y Ciencias Forenses",
      
      area_posgrado_original == "Geoarqueología. Geomorfología. Geología. Estratigrafia. Suelos" ~
        "Geociencias",
      
      area_posgrado_original == "Gestión del patrimonio cultural. Curaduría y restauración. Arquitectura. Estudios urbanisticos. Museología. Artes" ~
        "Patrimonio, Museología y Arquitectura",
      
      area_posgrado_original == "SIG. Geografía. Estudios territoriales. Ciencias Ambientales. Catastro. Teledetección. Arqueobotánica" ~
        "SIG, Geografía y Ciencias Ambientales",
      
      area_posgrado_original == "Ciencias de datos. Ingeniería de sistemas. Analítica de datos. Inteligencia artificial" ~
        "Tecnología",
      
      area_posgrado_original == "Administración. Economia. Gerencia de proyectos." ~
        "Administración y Economía",
      
      area_posgrado_original == "Zooarqueología. Biología. Bioarqueología. Osteología. Medicina. Nurición. Paleoantropologia" ~
        "Zooarqueología y Biología",
      
      area_posgrado_original == "Zooarqueología. Biología. Bioarqueología. Osteología. Medicina. Nutrición. Paleoantropologia. Biología molecular." ~
        "Ciencias de la salud",
      
      area_posgrado_original == "Otro" ~
        "Otro",
      
      TRUE ~ "Otro"
    )
  )
table(
  encuesta_limpia$area_posgrado,
  useNA = "ifany"
)

#_____________________________________________________________________________
#percepcion_remuneracion

unique(encuesta_limpia$percepcion_remuneracion)

table(
  encuesta_limpia$percepcion_remuneracion,
  useNA = "ifany"
)

#_____________________________________________________________________________
#solucion_profesion

unique(encuesta_limpia$solucion_profesion)

table(
  encuesta_limpia$solucion_profesion,
  useNA = "ifany"
)

#_____________________________________________________________________________
#volveria_elegir

unique(encuesta_limpia$volveria_elegir)

table(
  encuesta_limpia$volveria_elegir,
  useNA = "ifany"
)

names(encuesta)[23]

table(
  encuesta[[names(encuesta)[23]]],
  useNA = "ifany"
)

unique(
  encuesta[[names(encuesta)[23]]]
)

encuesta_limpia$volveria_elegir <- encuesta[[names(encuesta)[23]]]

table(
  encuesta_limpia$volveria_elegir,
  useNA = "ifany"
)

