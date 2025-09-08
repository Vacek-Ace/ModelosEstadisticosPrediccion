# ===============================================
# Script para generar todas las soluciones en HTML
# Ejecutar desde la RAÍZ del proyecto  
# Uso: Rscript -e "source('ejercicios/soluciones/generar_soluciones.R'); generar_todas_soluciones()"
# ===============================================

generar_todas_soluciones <- function() {
  cat("Generando todas las soluciones en HTML...\n")
  
  # Cambiar al directorio de soluciones
  setwd("ejercicios/soluciones")
  
  # Renderizar todo el libro de soluciones
  cat("Renderizando libro completo de soluciones...\n")
  system("quarto render")
  
  # Volver al directorio raíz
  setwd("../..")
  
  cat("✓ Libro de soluciones generado en: ejercicios/soluciones/soluciones_html/\n")
  cat("✓ Archivo principal: ejercicios/soluciones/soluciones_html/index.html\n")
  cat("¡Proceso completado!\n")
}

# Función para generar una solución específica
generar_solucion <- function(tema) {
  archivo <- paste0("tema", tema, "_soluciones.qmd")
  if (tema == "avanzados") {
    archivo <- "ejercicios_avanzados_soluciones.qmd"
  }
  
  cat("Generando solución:", archivo, "\n")
  
  setwd("ejercicios/soluciones")
  system(paste("quarto render", archivo))
  setwd("../..")
  
  cat("✓ Solución generada\n")
}

# Función para abrir las soluciones en el navegador
abrir_soluciones <- function() {
  # Detectar si estamos en el directorio de soluciones o en la raíz
  if (basename(getwd()) == "soluciones") {
    ruta_index <- file.path("soluciones_html", "index.html")
  } else {
    ruta_index <- file.path("ejercicios", "soluciones", "soluciones_html", "index.html")
  }
  
  # Convertir a ruta absoluta
  ruta_index <- normalizePath(ruta_index, mustWork = FALSE)
  
  if (file.exists(ruta_index)) {
    # Abrir en el navegador predeterminado
    if (.Platform$OS.type == "windows") {
      shell.exec(ruta_index)
    } else if (Sys.info()["sysname"] == "Darwin") {
      system(paste("open", ruta_index))
    } else {
      system(paste("xdg-open", ruta_index))
    }
    cat("✓ Soluciones abiertas en el navegador\n")
    cat("📁 Ubicación:", ruta_index, "\n")
  } else {
    cat("✗ Archivo de soluciones no encontrado. Ejecuta primero generar_todas_soluciones()\n")
    cat("📁 Buscando en:", ruta_index, "\n")
    cat("📁 Directorio actual:", getwd(), "\n")
  }
}
