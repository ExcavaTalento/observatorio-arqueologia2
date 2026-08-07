---
title: "Resumen Ejecutivo"
page-layout: full
---



# Resumen Ejecutivo

## Indicadores principales

::: {.kpi-grid}

::: {.kpi-card}

### Participantes

**185**

:::

::: {.kpi-card}

### Departamentos

**24**

:::

::: {.kpi-card}

### Formación predominante

**Pregrado**

:::

::: {.kpi-card}

### Ingreso predominante

**< 2 millones**

:::

:::

## Perfil de los participantes

### Género


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  genero,
  labels = ~genero,
  values = ~n,
  type = "pie",
  hole = 0.55
)
```

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-13660bc321e40bb59674" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-13660bc321e40bb59674">{"x":{"visdat":{"1fac36d11cb5":["function () ","plotlyVisDat"]},"cur_data":"1fac36d11cb5","attrs":{"1fac36d11cb5":{"labels":{},"values":{},"hole":0.55000000000000004,"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"pie"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"labels":["Hombre","Mujer","Genero no binario","Prefiero no decirlo","Helicóptero de ataque Apache","Trans"],"values":[103,76,2,2,1,1],"hole":0.55000000000000004,"type":"pie","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(255,255,255,1)"}},"frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


### Edad


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  edad,
  x = ~edad,
  y = ~n,
  type = "bar"
)
```

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-0724599b4fc52da68613" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-0724599b4fc52da68613">{"x":{"visdat":{"1fac79a06b15":["function () ","plotlyVisDat"]},"cur_data":"1fac79a06b15","attrs":{"1fac79a06b15":{"x":{},"y":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"edad","type":"category","categoryorder":"array","categoryarray":["20 años - 25 años","26 años - 30 años","31 años - 35 años","36 años - 40 años","41 años - 45 años","46 años -50 años","50 años o más"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"n"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["26 años - 30 años","31 años - 35 años","36 años - 40 años","20 años - 25 años","41 años - 45 años","50 años o más","46 años -50 años"],"y":[52,44,26,25,17,14,7],"type":"bar","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


## Formación


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  formacion,
  x = ~formacion,
  y = ~n,
  type = "bar"
)
```

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-e3169373e47d4480037f" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-e3169373e47d4480037f">{"x":{"visdat":{"1fac3455100b":["function () ","plotlyVisDat"]},"cur_data":"1fac3455100b","attrs":{"1fac3455100b":{"x":{},"y":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"formacion","type":"category","categoryorder":"array","categoryarray":["Doctorado","Especializacion","Estudiante de pregrado","Maestría","Posdoctorado","Pregrado"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"n"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["Pregrado","Maestría","Especializacion","Doctorado","Estudiante de pregrado","Posdoctorado"],"y":[109,30,24,10,10,2],"type":"bar","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


## Experiencia


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  experiencia,
  x = ~experiencia,
  y = ~n,
  type = "bar"
)
```

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-b106574644980d5fa456" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-b106574644980d5fa456">{"x":{"visdat":{"1fac2c421f1":["function () ","plotlyVisDat"]},"cur_data":"1fac2c421f1","attrs":{"1fac2c421f1":{"x":{},"y":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"experiencia","type":"category","categoryorder":"array","categoryarray":["11 y 15 años","4 a 6 años","7 a 10 años","Entre 1 a 3 años","Menos de 1 año","No tengo experiencia"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"n"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["Entre 1 a 3 años","7 a 10 años","4 a 6 años","11 y 15 años","Menos de 1 año","No tengo experiencia"],"y":[47,44,40,37,15,2],"type":"bar","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


## Ingresos


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  ingreso,
  x = ~ingreso,
  y = ~n,
  type = "bar"
)
```

::: {.cell-output .cell-output-stderr}

```
Warning: Ignoring 1 observations
```


:::

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-ddf40849e10b36b3056e" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-ddf40849e10b36b3056e">{"x":{"visdat":{"1fac257d38a2":["function () ","plotlyVisDat"]},"cur_data":"1fac257d38a2","attrs":{"1fac257d38a2":{"x":{},"y":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"xaxis":{"domain":[0,1],"automargin":true,"title":"ingreso","type":"category","categoryorder":"array","categoryarray":["6 millones a 7 millones","7 millones a 8 millones","9 millones a 10 millones","De 2 millones a 2.5 millones","De 2.5 millones a 3 millones","De 3 millones a 4 millones","De 4 millones a 5 millones","De 5 millones a 6 millones","Más de 10 millones","Menos de 2 millones de pesos","Nunca he ganado nada"]},"yaxis":{"domain":[0,1],"automargin":true,"title":"n"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":["De 3 millones a 4 millones","De 4 millones a 5 millones","De 5 millones a 6 millones","De 2.5 millones a 3 millones","Menos de 2 millones de pesos","6 millones a 7 millones","De 2 millones a 2.5 millones","7 millones a 8 millones","Más de 10 millones","Nunca he ganado nada","9 millones a 10 millones"],"y":[43,39,25,20,15,11,11,6,5,5,3],"type":"bar","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::


## Trabaja actualmente


::: {.cell}

```{.r .cell-code}
plotly::plot_ly(
  activo,
  labels = ~activo,
  values = ~n,
  type = "pie",
  hole = 0.6
)
```

::: {.cell-output-display}

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-a2db1142ae117988e56d" style="width:100%;height:464px;"></div>
<script type="application/json" data-for="htmlwidget-a2db1142ae117988e56d">{"x":{"visdat":{"1fac190d5275":["function () ","plotlyVisDat"]},"cur_data":"1fac190d5275","attrs":{"1fac190d5275":{"labels":{},"values":{},"hole":0.59999999999999998,"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"pie"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"labels":["Si, es mi profesión principal","No actualmente, pero lo he hecho antes","Si, ocasionalmente","No"],"values":[142,27,12,4],"hole":0.59999999999999998,"type":"pie","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(255,255,255,1)"}},"frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

:::
:::



