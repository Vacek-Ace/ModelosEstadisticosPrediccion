# ===============================================
# Script para generar PDF con el listado/portada del software utilizado
# Ejecutar desde la RAÍZ del proyecto
# Uso: Rscript -e "source('laboratorios/generar_software.R'); crear_software_completa()"
# ===============================================

crear_portada_software <- function() {
  cat("Generando portada de software utilizado...\n")
  
  setwd("laboratorios")
  
  # Crear un portada.qmd temporal solo para la portada
  portada_temp <- '
---
format:
  pdf:
    pdf-engine: weasyprint
    include-before-body: portada.html
    css: ../estilos.css
---

Código fuente preservado en Software Heritage para garantizar el acceso abierto y la reproducibilidad.

<a href="https://archive.softwareheritage.org/swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478;origin=https://github.com/URJCDSLab/ModelosEstadisticosPrediccion;visit=swh:1:snp:f41a70a106d5f90b6ddd40440bc7d51fdd5d44b7;anchor=swh:1:rev:cc85115fd6a3487169464d1b7e7d815ed0e270cf"><img src="https://archive.softwareheritage.org/badge/swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478/" alt="Archived | swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478"/></a>
'
  
  writeLines(portada_temp, "portada.qmd")
  system("quarto render portada.qmd --to pdf")
  
  if (!file.exists("portada.pdf")) {
    setwd("..")  # Volver a la raíz antes del error
    stop("No se generó portada.pdf")
  }
  
  setwd("..")  # Volver a la raíz
  cat("Portada creada: laboratorios/portada.pdf\n")
}

crear_software_pdf <- function() {
  cat("Generando documento PDF del listado de software...\n")
  
  setwd("laboratorios")
  
  # Crear configuración temporal sin portada HTML
  config_temp <- '
---
lang: es
format:
  pdf:
    documentclass: scrreprt
    title-block-banner: false
    toc: true
    toc-title: "Índice programas de ordenador"
    title: "Software utilizado - Modelos Estadísticos de Predicción"
    author: "Equipo del curso"
---
'
  
  # Leer el contenido original sin el YAML
  contenido_original <- readLines("software_utilizado.qmd")
  inicio_contenido <- which(grepl("^---$", contenido_original))[2] + 1
  contenido_sin_yaml <- contenido_original[inicio_contenido:length(contenido_original)]
  
  # Crear archivo temporal
  writeLines(c(config_temp, contenido_sin_yaml), "software_temp.qmd")
  
  # Renderizar
  system("quarto render software_temp.qmd --to pdf")
  
  # Limpiar temporal
  file.remove("software_temp.qmd")
  if (file.exists("portada.qmd")) file.remove("portada.qmd")
  
  setwd("..")  # Volver a la raíz
  cat("Software generado en laboratorios/\n")
}

unir_pdfs_software <- function() {
  cat("Procesando PDFs de software...\n")
  
  setwd("laboratorios")
  
  # Buscar el PDF del software
  if (file.exists("software_temp.pdf")) {
    # Quitar primera página del software
    system("pdftk software_temp.pdf cat 2-end output software_sin_primera.pdf")
    
    # Unir portada + software sin primera página  
    system("pdftk portada.pdf software_sin_primera.pdf cat output SoftwareUtilizadoModelosEstadisticosPrediccion.pdf")
    
    # Limpiar temporales
    file.remove(c("software_temp.pdf", "software_sin_primera.pdf"))
  } else {
    cat("Error: No se encontró software_temp.pdf\n")
  }
  
  # Borrar portada original
  if (file.exists("portada.pdf")) file.remove("portada.pdf")
  
  setwd("..")
  
  cat("Software completo: laboratorios/SoftwareUtilizadoModelosEstadisticosPrediccion.pdf\n")
}

crear_software_completa <- function() {
  crear_portada_software()
  crear_software_pdf()
  unir_pdfs_software()
  cat("¡Proceso de generación del PDF de software completado!\n")
}

check <- function() {
  cat("Comprobando dependencias mínimas para generar el PDF de software...\n")
  deps <- c("quarto", "pdftk")
  for (d in deps) {
    res <- system(paste(d, "--version"), ignore.stdout = TRUE, ignore.stderr = TRUE)
    if (res != 0) cat(sprintf("Advertencia: '%s' no parece estar disponible en PATH.\n", d))
  }
  cat("Verifica también que 'weasyprint' esté disponible si lo usas como pdf-engine en Quarto.\n")
}
