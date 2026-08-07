#========================================================
# 03_renombrar_variables.R
# Renombra variables y crea la base procesada
#========================================================

source("R/00_paquetes.R")

#--------------------------------------------------------
# Leer datos
#--------------------------------------------------------

encuesta <- read_csv(
  "data/raw/encuesta-arqueologia.csv",
  show_col_types = FALSE
)

encuesta <- clean_names(encuesta)

#--------------------------------------------------------
# Renombrar variables
#--------------------------------------------------------

encuesta <- encuesta %>%
  rename(
    
    fecha = timestamp,
    
    activo = x1_actualmente_trabajas_en_arqueologia,
    
    genero = x2_con_que_genero_te_identificas,
    
    edad = x3_en_que_rango_de_edad_te_encuentras,
    
    area_trabajo = x4_en_cual_de_las_siguientes_areas_has_desarrollado_principalmente_tu_trabajo,
    
    fuentes_ingreso = x5_actualmente_como_obtienes_tus_ingresos_relacionados_con_arqueologia_puedes_seleccionar_varias_opciones,
    
    experiencia = x6_cuantos_anos_tienes_de_experiencia_en_arqueologia,
    
    formacion = x7_cual_es_tu_nivel_de_formacion_academica,
    
    ingreso = x8_cual_es_tu_ingreso_mensual_promedio_relacionado_con_la_arqueologia_si_tienes_varias_fuentes_un_promedio_general,
    
    departamento = x9_en_que_departamento_realizas_la_mayor_parte_de_tu_trabajo_si_tienes_varios_elige_los_2_mas_significativos_tambien_aplica_trabajo_academico,
    
    factor_ingresos = x10_en_tu_experiencia_que_factor_ha_tenido_mayor_impacto_en_tus_ingresos_como_arqueolog_lo_que_mas_te_ha_ayudado_a_subir_tu_salario_considerablemente,
    
    cargo = x11_cual_es_actualmente_tu_cargo_o_rol_en_arqueologia,
    
    tipo_empresa = x12_en_que_tipo_de_proyecto_o_empresa_trabajas_principalmente_si_tienes_varios_elige_el_mas_importante,
    
    estabilidad = x13_tus_ingresos_en_arqueologia_son,
    
    dias_campo = x14_en_un_mes_tipico_cuantos_dias_realizas_trabajo_de_campo,
    
    personas_cargo = x15_cuantas_personas_tienes_a_cargo_dentro_de_tu_proyecto_o_empleo,
    
    herramientas = x16_cuales_de_herramientas_tecnologicas_utilizas_mas_para_tus_trabajos_en_arqueologia_elige_todas_las_que_sepas_manejar,
    
    problema_principal = x17_en_que_grado_consideras_tu_que_es_el_mayor_problema_del_mercado_laboral_de_la_arqueologia_en_colombia_elige_el_que_consideras_mas_relevante,
    
    posgrado_valio = x18_valio_la_pena_para_ti_hacer_posgrado_en_arqueologia_a_nivel_de_salario_y_desarrollo_profesional,
    
    area_posgrado = x19_en_que_area_esta_tu_posgrado_especializacion_maestria_o_doctorado_elige_solo_una,
    
    remuneracion = x20_segun_tu_experiencia_y_lo_que_notas_crees_que_tu_remuneracion_actual_es,
    
    mejora_profesion = x21_si_pudieras_cambiar_una_sola_cosa_para_mejorar_la_profesion_de_los_arqueologos_en_colombia_cual_seria,
    
    volveria_estudiar = x22_si_pudieras_decidir_de_nuevo_volverias_a_elegir_arqueologia_en_colombia_como_profesion_califica_de_1_a_5_1_no_2_probablemente_no_3_quizas_tal_vez_4_probablemente_si_5_claro_me_encanta,
    
    comentarios = comentarios_y_sugerencias_que_nos_quieras_hacer_o_compartir_puedes_dejarnos_reflexiones_y_anecdotas_sobre_tu_vida_profesional_queremos_escucharte
  )

#--------------------------------------------------------
# Guardar base procesada
#--------------------------------------------------------

write_csv(
  encuesta,
  "data/processed/encuesta_procesada.csv"
)

cat("Base procesada creada correctamente.\n")

