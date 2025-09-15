# ===============================================
# Script para generar PDF con el listado/portada del software utilizado
# Ejecutar desde la RAÍZ del proyecto
# Uso: Rscript -e "source('laboratorios/generar_software.R'); crear_software_completa()"
# ===============================================

crear_portada_software <- function() {
  cat("Generando portada de software utilizado...\n")
  
  setwd("laboratorios")
  
  # Crear un portada.qmd temporal solo para la portada
  portada_temp <- '\n---\nformat:\n  pdf:\n    pdf-engine: weasyprint\n    include-before-body: portada.html\n    css: ../estilos.css\n---\n\nSoftware utilizado en la asignatura.\n'
  
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
  # Crear configuración temporal similar al patrón de la guía (sin la portada HTML)
  config_temp <- '\n---\nlang: es\nformat:\n  pdf:\n    documentclass: scrreprt\n    title-block-banner: false\n    toc: true\n    toc-title: "Índice programas de ordenador"\n    title: "Software utilizado - Modelos Estadísticos de Predicción"\n    author: "Equipo del curso"\n---\n'

  # Leer el contenido original sin el YAML
  contenido_original <- readLines("software_utilizado.qmd")
  inicio_contenido <- which(grepl("^---$", contenido_original))[2] + 1
  contenido_sin_yaml <- contenido_original[inicio_contenido:length(contenido_original)]

  # Crear archivo temporal
  writeLines(c(config_temp, contenido_sin_yaml), "software_temp.qmd")

  # Renderizar a PDF (estilo guía)
  system("quarto render software_temp.qmd --to pdf")

  # Limpiar temporal
  if (file.exists("software_temp.qmd")) file.remove("software_temp.qmd")
  if (file.exists("portada.qmd")) file.remove("portada.qmd")

  setwd("..")  # Volver a la raíz
  cat("Documento de software generado en laboratorios/\n")
}

unir_pdfs_software <- function() {
  cat("Unificando portada y documento de software...\n")
  
  setwd("laboratorios")
  
  # Preferir archivo software_temp.pdf si existe
  if (file.exists("software_temp.pdf")) {
    content_pdf <- "software_temp.pdf"
  } else if (file.exists("software_utilizado.pdf")) {
    content_pdf <- "software_utilizado.pdf"
  } else {
    setwd("..")
    stop("No se encontró PDF intermedio para unificar (software_temp.pdf o software_utilizado.pdf)")
  }

  # Intentar usar pdftk para quitar la primera página del contenido (si queremos) y unir
  if (system("pdftk --version", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0) {
    # quitar primera página del contenido y unir
    tmp_no_first <- "software_sin_primera.pdf"
    cmd1 <- paste("pdftk", shQuote(content_pdf), "cat 2-end output", shQuote(tmp_no_first))
    rc1 <- system(cmd1)
    if (rc1 != 0 || !file.exists(tmp_no_first)) {
      # si no se pudo quitar la primera página, unir todo
      cmd2 <- paste("pdftk", shQuote("portada.pdf"), shQuote(content_pdf), "cat output", shQuote("SoftwareUtilizadoModelosEstadisticosPrediccion.pdf.pdf"))
      system(cmd2)
    } else {
      cmd3 <- paste("pdftk", shQuote("portada.pdf"), shQuote(tmp_no_first), "cat output", shQuote("SoftwareUtilizadoModelosEstadisticosPrediccion.pdf"))
      system(cmd3)
      file.remove(tmp_no_first)
    }
  } else {
    # Usar pdftools como fallback
    if (!requireNamespace("pdftools", quietly = TRUE)) {
      setwd("..")
      stop("Necesitas 'pdftools' o 'pdftk' para unir PDFs")
    }
    # Intentar combinar portada + contenido (sin eliminar páginas)
    pdftools::pdf_combine(c("portada.pdf", content_pdf), output = "SoftwareUtilizadoModelosEstadisticosPrediccion.pdf.pdf")
  }
  # Borrar el PDF de contenido intermedio si existía
  if (file.exists("software_temp.pdf")) file.remove("software_temp.pdf")
  
  # Borrar portada original
  if (file.exists("portada.pdf")) file.remove("portada.pdf")
  
  setwd("..")
  cat("Archivo final creado: laboratorios/SoftwareUtilizadoModelosEstadisticosPrediccion.pdf.pdf\n")
}

crear_software_completa <- function() {
  crear_portada_software()
  crear_software_pdf()
  unir_pdfs_software()
  cat("Proceso de generación del PDF de software completado!\n")
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
