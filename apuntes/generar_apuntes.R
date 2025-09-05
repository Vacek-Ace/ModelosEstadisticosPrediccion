# ===============================================
# Script simplificado para generar libro completo
# Ejecutar desde la RAÍZ del proyecto
# Uso: Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"
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

crear_libro <- function() {
  cat("Generando libro...\n")
  
  system("quarto render --to pdf --output-dir apuntes/apuntes_pdf")
  
  # Buscar el PDF del libro
  pdf_files <- list.files("apuntes/apuntes_pdf", pattern = "\\.pdf$", full.names = FALSE)
  
  if (length(pdf_files) == 0) {
    stop("No se generó el PDF del libro")
  }
  
  cat("Libro creado en apuntes/apuntes_pdf/\n")
}

unir_pdfs <- function() {
  cat("Procesando PDFs...\n")
  
  setwd("apuntes")
  
  # Buscar el archivo del libro
  pdf_files <- list.files("apuntes_pdf", pattern = "\\.pdf$", full.names = FALSE)
  apuntes_pdf <- pdf_files[1]
  
  setwd("apuntes_pdf")
  
  # Quitar primera página del libro
  system(paste0("pdftk ", apuntes_pdf, " cat 2-end output libro_sin_primera.pdf"))
  
  # Unir portada + libro sin primera página  
  system("pdftk ../portada.pdf libro_sin_primera.pdf cat output ApuntesModelosEstadisticosPrediccion.pdf")
  
  # Limpiar temporales
  file.remove(c(apuntes_pdf, "libro_sin_primera.pdf"))
  
  setwd("..")
  
  # Borrar portada original
  file.remove("portada.pdf")
  
  setwd("..")
  
  cat("Libro completo: apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf\n")
}

crear_libro_completo <- function() {
  crear_portada()
  crear_libro()
  unir_pdfs()
  cat("¡Proceso completado!\n")
}