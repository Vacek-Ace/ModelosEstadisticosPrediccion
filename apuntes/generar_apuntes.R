# ===============================================
# Script simplificado para generar apuntes completos
# Ejecutar desde la RAÍZ del proyecto
# Uso: Rscript -e "source('apuntes/generar_apuntes.R'); crear_apuntes_completo()"
# ===============================================

crear_portada <- function() {
  cat("Generando portada...\n")
  
  setwd("apuntes")
  system("quarto render portada.qmd --to pdf")
  
  if (!file.exists("portada.pdf")) {
    setwd("..")  # Volver a la raíz antes del error
    stop("No se generó portada.pdf")
  }
  
  setwd("..")  # Volver a la raíz
  cat("Portada creada: apuntes/portada.pdf\n")
}

crear_apuntes <- function() {
  cat("Generando apuntes...\n")
  
  system("quarto render --to pdf --output-dir apuntes/apuntes_pdf")
  
  # Buscar el PDF de los apuntes
  pdf_files <- list.files("apuntes/apuntes_pdf", pattern = "\\.pdf$", full.names = FALSE)
  
  if (length(pdf_files) == 0) {
    stop("No se generó el PDF de los apuntes")
  }
  
  cat("Apuntes creados en apuntes/apuntes_pdf/\n")
}

unir_pdfs <- function() {
  cat("Procesando PDFs...\n")
  
  setwd("apuntes")
  
  # Buscar el archivo de los apuntes
  pdf_files <- list.files("apuntes_pdf", pattern = "\\.pdf$", full.names = FALSE)
  apuntes_pdf <- pdf_files[1]
  
  setwd("apuntes_pdf")
  
  # Quitar primera página de los apuntes
  system(paste0("pdftk ", apuntes_pdf, " cat 2-end output apuntes_sin_primera.pdf"))
  
  # Unir portada + apuntes sin primera página  
  system("pdftk ../portada.pdf apuntes_sin_primera.pdf cat output ApuntesModelosEstadisticosPrediccion.pdf")
  
  # Limpiar temporales
  file.remove(c(apuntes_pdf, "apuntes_sin_primera.pdf"))
  
  setwd("..")
  
  # Borrar portada original
  file.remove("portada.pdf")
  
  setwd("..")
  
  cat("Apuntes completos: apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf\n")
}

crear_apuntes_completo <- function() {
  crear_portada()
  crear_apuntes()
  unir_pdfs()
  cat("¡Proceso completado!\n")
}