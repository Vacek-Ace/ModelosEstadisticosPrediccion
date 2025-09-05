# ===============================================
# Script para generar guía de estudio con portada personalizada
# Ejecutar desde la RAÍZ del proyecto  
# Uso: Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"
# ===============================================

crear_portada_guia <- function() {
  cat("Generando portada de guía de estudio...\n")
  
  setwd("guia_estudio")
  
  # Crear un portada.qmd temporal solo para la portada
  portada_temp <- '
---
format:
  pdf:
    pdf-engine: weasyprint
    include-before-body: portada.html
    css: ../estilos.css
---

Material de apoyo para el estudio de Modelos Estadísticos de Predicción.
'
  
  writeLines(portada_temp, "portada.qmd")
  system("quarto render portada.qmd --to pdf")
  
  if (!file.exists("portada.pdf")) {
    setwd("..")  # Volver a la raíz antes del error
    stop("No se generó portada.pdf")
  }
  
  setwd("..")  # Volver a la raíz
  cat("Portada creada: guia_estudio/portada.pdf\n")
}

crear_guia <- function() {
  cat("Generando guía de estudio...\n")
  
  setwd("guia_estudio")
  
  # Crear configuración temporal sin portada HTML
  config_temp <- '
---
lang: es
format:
  pdf:
    documentclass: scrreprt
    title-block-banner: false
    toc: true
    toc-title: "Índice de Contenidos"
    title: "Guía de Estudio - Modelos Estadísticos de Predicción"
    author: "Víctor Aceña Gil & Isaac Martín de Diego"
---
'
  
  # Leer el contenido original sin el YAML
  contenido_original <- readLines("guia_estudio.qmd")
  inicio_contenido <- which(grepl("^---$", contenido_original))[2] + 1
  contenido_sin_yaml <- contenido_original[inicio_contenido:length(contenido_original)]
  
  # Crear archivo temporal
  writeLines(c(config_temp, contenido_sin_yaml), "guia_temp.qmd")
  
  # Renderizar
  system("quarto render guia_temp.qmd --to pdf")
  
  # Limpiar temporal
  file.remove("guia_temp.qmd")
  if (file.exists("portada.qmd")) file.remove("portada.qmd")
  
  setwd("..")  # Volver a la raíz
  cat("Guía creada en guia_estudio/\n")
}

unir_pdfs_guia <- function() {
  cat("Procesando PDFs de guía de estudio...\n")
  
  setwd("guia_estudio")
  
  # Buscar el PDF de la guía
  if (file.exists("guia_temp.pdf")) {
    # Quitar primera página de la guía
    system("pdftk guia_temp.pdf cat 2-end output guia_sin_primera.pdf")
    
    # Unir portada + guía sin primera página  
    system("pdftk portada.pdf guia_sin_primera.pdf cat output GuiaEstudioModelosEstadisticosPrediccion.pdf")
    
    # Limpiar temporales
    file.remove(c("guia_temp.pdf", "guia_sin_primera.pdf"))
  } else {
    cat("Error: No se encontró guia_temp.pdf\n")
  }
  
  # Borrar portada original
  if (file.exists("portada.pdf")) file.remove("portada.pdf")
  
  setwd("..")
  
  cat("Guía completa: guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf\n")
}

crear_guia_completa <- function() {
  crear_portada_guia()
  crear_guia()
  unir_pdfs_guia()
  cat("¡Proceso de guía de estudio completado!\n")
}
