# Script para generar el libro completo de Modelos Estadísticos de Predicción
# Versión corregida con portada original + índice LaTeX separado + Software

# Cargar librerías necesarias
library(pdftools)
library(quarto)

# Función para mostrar progreso
mostrar_progreso <- function(mensaje) {
  cat(paste0("[", Sys.time(), "] ", mensaje, "\n"))
}

# Función para obtener páginas de inicio reales de cada sección
obtener_paginas_reales <- function() {
  mostrar_progreso("Calculando páginas reales de cada documento...")
  
  # Páginas base
  paginas_portada <- pdf_length("libro/portada.pdf")
  paginas_indice <- pdf_length("libro/indice.pdf")
  
  # Para la guía de estudio, vamos a estimar las páginas de cada subsección
  # basándonos en la estructura típica del documento
  guia_inicio <- paginas_portada + paginas_indice + 1
  
  # Páginas aproximadas para subsecciones de guía (estimación basada en contenido típico)
  guia_subsecciones <- list(
    planificacion = guia_inicio + 1,
    objetivos = guia_inicio + 2, 
    metodologia = guia_inicio + 3,
    evaluacion = guia_inicio + 4,
    recursos = guia_inicio + 5
  )
  
  # Para apuntes, necesitamos leer el PDF y estimar las secciones
  apuntes_inicio <- guia_inicio + pdf_length("guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf")
  
  # Estimación basada en el tamaño típico de cada tema en apuntes
  apuntes_subsecciones <- list(
    introduccion = apuntes_inicio + 1,
    regresion_simple = apuntes_inicio + 18,   # Estimado
    regresion_multiple = apuntes_inicio + 61, # Estimado  
    ingenieria = apuntes_inicio + 128,        # Estimado
    seleccion = apuntes_inicio + 172,         # Estimado
    glm = apuntes_inicio + 198                # Estimado
  )
  
  # Para diapositivas
  diapositivas_inicio <- apuntes_inicio + pdf_length("apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf")
  
  # Estimación basada en las diapositivas típicas (47 páginas por tema aprox)
  diapositivas_subsecciones <- list(
    tema0 = diapositivas_inicio + 1,
    tema1 = diapositivas_inicio + 48,
    tema2 = diapositivas_inicio + 106, 
    tema3 = diapositivas_inicio + 162,
    tema4 = diapositivas_inicio + 217,
    tema5 = diapositivas_inicio + 251
  )
  
  # Para ejercicios
  ejercicios_inicio <- diapositivas_inicio + pdf_length("diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf")
  
  # Estimación basada en ejercicios (5 páginas por sección aprox)
  ejercicios_subsecciones <- list(
    regresion_simple = ejercicios_inicio + 1,
    regresion_multiple = ejercicios_inicio + 6,
    ingenieria = ejercicios_inicio + 11,
    seleccion = ejercicios_inicio + 16,
    glm = ejercicios_inicio + 20,
    avanzados = ejercicios_inicio + 22
  )
  
  # Para software (nuevo)
  software_inicio <- ejercicios_inicio + pdf_length("ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf")
  
  return(list(
    portada = 1,
    indice = paginas_portada + 1,
    guia_inicio = guia_inicio,
    guia_sub = guia_subsecciones,
    apuntes_inicio = apuntes_inicio,
    apuntes_sub = apuntes_subsecciones,
    diapositivas_inicio = diapositivas_inicio,
    diapositivas_sub = diapositivas_subsecciones,
    ejercicios_inicio = ejercicios_inicio,
    ejercicios_sub = ejercicios_subsecciones,
    software_inicio = software_inicio
  ))
}

mostrar_progreso("Iniciando generación del libro completo...")

# Obtener páginas reales calculadas
paginas_reales <- obtener_paginas_reales()

#---------------------------
# 1. GENERAR PORTADA E ÍNDICE
#---------------------------
mostrar_progreso("Generando portada original...")

# Cambiar al directorio libro para generar la portada
setwd("libro")
quarto_render("portada.qmd", output_file = "portada.pdf", quiet = TRUE)

mostrar_progreso("Generando índice separado...")
quarto_render("indice.qmd", output_file = "indice.pdf", quiet = TRUE)
setwd("..")

mostrar_progreso("Portada e índice generados correctamente")

#---------------------------
# 2. VERIFICAR ARCHIVOS PDF
#---------------------------
pdfs_necesarios <- c(
  "libro/portada.pdf",
  "libro/indice.pdf",
  "guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf",
  "apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf",
  "diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf",
  "ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf",
  "laboratorios/SoftwareUtilizadoModelosEstadisticosPrediccion.pdf"
)

# Verificar que todos los archivos existen
for (pdf in pdfs_necesarios) {
  if (!file.exists(pdf)) {
    stop(paste("Error: No se encuentra el archivo", pdf))
  }
}

mostrar_progreso("Todos los archivos PDF verificados")

#---------------------------
# 3. CALCULAR PÁGINAS DINÁMICAMENTE
#---------------------------
mostrar_progreso("Calculando páginas de cada documento...")

# Obtener número de páginas de cada documento
paginas_portada <- pdf_length("libro/portada.pdf")
paginas_indice <- pdf_length("libro/indice.pdf")
paginas_guia <- pdf_length("guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf")
paginas_apuntes <- pdf_length("apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf")
paginas_diapositivas <- pdf_length("diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf")
paginas_ejercicios <- pdf_length("ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf")
paginas_software <- pdf_length("laboratorios/SoftwareUtilizadoModelosEstadisticosPrediccion.pdf")

mostrar_progreso(sprintf("Páginas: Portada=%d, Índice=%d, Guía=%d, Apuntes=%d, Diapositivas=%d, Ejercicios=%d, Software=%d", 
                paginas_portada, paginas_indice, paginas_guia, paginas_apuntes, paginas_diapositivas, paginas_ejercicios, paginas_software))

# Calcular páginas de inicio para bookmarks
pagina_inicio_indice <- paginas_portada + 1
pagina_inicio_guia <- pagina_inicio_indice + paginas_indice
pagina_inicio_apuntes <- pagina_inicio_guia + paginas_guia
pagina_inicio_diapositivas <- pagina_inicio_apuntes + paginas_apuntes  
pagina_inicio_ejercicios <- pagina_inicio_diapositivas + paginas_diapositivas
pagina_inicio_software <- pagina_inicio_ejercicios + paginas_ejercicios

mostrar_progreso(sprintf("Páginas de inicio: Índice=%d, Guía=%d, Apuntes=%d, Diapositivas=%d, Ejercicios=%d, Software=%d",
                pagina_inicio_indice, pagina_inicio_guia, pagina_inicio_apuntes, pagina_inicio_diapositivas, pagina_inicio_ejercicios, pagina_inicio_software))

#---------------------------
# 4. COMBINAR TODOS LOS PDFs
#---------------------------
mostrar_progreso("Combinando todos los documentos PDF...")

pdf_combine(input = pdfs_necesarios, 
           output = "libro/LibroCompletoModelosEstadisticos.pdf")

#---------------------------
# 5. AGREGAR BOOKMARKS
#---------------------------
mostrar_progreso("Agregando bookmarks al documento...")

# Verificar si pdftk está disponible
if (system("pdftk --version", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0) {
  
  # Crear archivo de bookmarks SOLO con los principales
  bookmarks_contenido <- c(
    "BookmarkBegin",
    "BookmarkTitle: Portada",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$portada),
    "BookmarkBegin",
    "BookmarkTitle: Indice General",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$indice),
    "BookmarkBegin",
    "BookmarkTitle: Guia de Estudio",
    "BookmarkLevel: 1", 
    paste0("BookmarkPageNumber: ", paginas_reales$guia_inicio),
    "BookmarkBegin",
    "BookmarkTitle: Apuntes Teoricos",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$apuntes_inicio),
    "BookmarkBegin",
    "BookmarkTitle: Diapositivas de Clase",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$diapositivas_inicio),
    "BookmarkBegin",
    "BookmarkTitle: Ejercicios Practicos",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$ejercicios_inicio),
    "BookmarkBegin",
    "BookmarkTitle: Software Utilizado",
    "BookmarkLevel: 1",
    paste0("BookmarkPageNumber: ", paginas_reales$software_inicio)
  )
  
  # Escribir archivo temporal de bookmarks con codificación Latin-1 para pdftk
  con <- file("libro/bookmarks_temp.txt", "w", encoding = "latin1")
  writeLines(bookmarks_contenido, con)
  close(con)
  
  # Aplicar bookmarks usando pdftk
  comando_pdftk <- paste("pdftk", 
                        shQuote("libro/LibroCompletoModelosEstadisticos.pdf"),
                        "update_info libro/bookmarks_temp.txt output",
                        shQuote("libro/temp_con_bookmarks.pdf"))
  
  resultado_pdftk <- system(comando_pdftk, ignore.stdout = TRUE)
  
  if (resultado_pdftk == 0) {
    file.rename("libro/temp_con_bookmarks.pdf", "libro/LibroCompletoModelosEstadisticos.pdf")
    file.remove("libro/bookmarks_temp.txt")
    mostrar_progreso("Bookmarks agregados exitosamente")
  } else {
    mostrar_progreso("Advertencia: No se pudieron agregar los bookmarks")
  }
  
} else {
  mostrar_progreso("Advertencia: pdftk no está disponible, se omitieron los bookmarks")
}

#---------------------------
# 6. MOSTRAR RESUMEN FINAL
#---------------------------
archivo_final <- "libro/LibroCompletoModelosEstadisticos.pdf"
paginas_totales <- pdf_length(archivo_final)
tamaño_mb <- round(file.size(archivo_final) / 1024 / 1024, 2)

cat("\n")
cat("===============================================\n")
cat("    LIBRO GENERADO EXITOSAMENTE\n")
cat("===============================================\n")
cat("Archivo:", archivo_final, "\n")
cat("Páginas totales:", paginas_totales, "\n")
cat("Tamaño del archivo:", tamaño_mb, "MB\n")
cat("\n")
cat("ESTRUCTURA DEL LIBRO:\n")
cat("- Portada: página 1\n")
cat("- Índice General: páginas", pagina_inicio_indice, "-", (pagina_inicio_guia - 1), "\n")
cat("- Guía de Estudio: páginas", pagina_inicio_guia, "-", (pagina_inicio_apuntes - 1), "\n")
cat("- Apuntes Teóricos: páginas", pagina_inicio_apuntes, "-", (pagina_inicio_diapositivas - 1), "\n") 
cat("- Diapositivas: páginas", pagina_inicio_diapositivas, "-", (pagina_inicio_ejercicios - 1), "\n")
cat("- Ejercicios: páginas", pagina_inicio_ejercicios, "-", (pagina_inicio_software - 1), "\n")
cat("- Software Utilizado: páginas", pagina_inicio_software, "-", paginas_totales, "\n")
cat("===============================================\n")

mostrar_progreso("Proceso completado exitosamente")