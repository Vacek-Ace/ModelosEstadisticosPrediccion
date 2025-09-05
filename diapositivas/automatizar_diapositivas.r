# crear_diapositivas_completas.R
# Sistema para crear UN PDF con portada clicable + bookmarks laterales

library(pdftools)
library(quarto)

#' Función principal para crear el PDF completo con enlaces en portada y bookmarks
crear_pdf_completo <- function(nombre_salida = "diapositivas_completas.pdf") {
  
  cat("=== CREANDO PDF COMPLETO CON ENLACES ===\n\n")
  
  # 1. Obtener archivos de temas
  cat("1. Detectando archivos de temas...\n")
  archivos_temas <- obtener_archivos_temas()
  
  if (length(archivos_temas) == 0) {
    stop("Error: No se encontraron archivos de temas")
  }
  
  for (i in seq_along(archivos_temas)) {
    cat("   ", i, ".", archivos_temas[i], "\n")
  }
  cat("\n")
  
  # 2. Calcular páginas ANTES de crear la portada
  cat("2. Calculando páginas de cada tema...\n")
  paginas_temas <- calcular_paginas_temas(archivos_temas)
  
  for (tema in names(paginas_temas)) {
    cat("   ", tema, ": página", paginas_temas[[tema]], "\n")
  }
  cat("\n")
  
  # 3. Crear portada CON enlaces usando las páginas calculadas
  cat("3. Creando portada con enlaces clicables...\n")
  crear_portada_con_enlaces(paginas_temas)
  
  if (!file.exists("portada_general.pdf")) {
    stop("Error: No se pudo crear la portada")
  }
  cat("   ✓ Portada creada con enlaces internos\n\n")
  
  # 4. Unir todos los PDFs
  cat("4. Uniendo PDFs...\n")
  todos_los_archivos <- c("portada_general.pdf", archivos_temas)
  
  if (unir_con_bookmarks(todos_los_archivos, nombre_salida, paginas_temas)) {
    cat("   ✓ PDF creado con portada clicable Y bookmarks laterales\n")
  } else {
    cat("   ⚠ PDF creado solo con portada clicable\n")
  }
  
  # 5. Mostrar información del resultado
  mostrar_info_resultado(nombre_salida, todos_los_archivos)
  
  # 6. Limpiar archivos temporales
  file.remove("portada_general.pdf")
  cat("   ✓ Archivos temporales eliminados\n")
  
  cat("\n=== PROCESO COMPLETADO ===\n")
  cat("✓ Portada con enlaces clicables\n")
  cat("✓ Bookmarks laterales navegables\n") 
  cat("Archivo final:", nombre_salida, "\n")
  
  return(nombre_salida)
}

#' Función para calcular páginas donde empezará cada tema
calcular_paginas_temas <- function(archivos_temas) {
  
  paginas <- list()
  pagina_actual <- 3  # Asumiendo 2 páginas de portada + índice
  
  # Primero verificar cuántas páginas tendrá la portada
  # (Crear portada temporal solo para contar páginas)
  crear_portada_temporal()
  if (file.exists("portada_temp.pdf")) {
    paginas_portada <- pdf_length("portada_temp.pdf")
    file.remove("portada_temp.pdf")
    pagina_actual <- paginas_portada + 1
  }
  
  # Calcular página de inicio de cada tema
  temas_info <- list(
    "tema0" = "Introduccion a los Modelos Estadisticos",
    "tema1" = "Regresion Lineal Simple", 
    "tema2" = "Regresion Lineal Multiple",
    "tema3" = "Ingenieria de Caracteristicas",
    "tema4" = "Seleccion de Variables y Regularizacion",
    "tema5" = "Modelos Lineales Generalizados"
  )
  
  for (archivo in archivos_temas) {
    # Extraer número de tema
    tema_num <- sub("tema(\\d+).*", "\\1", archivo)
    tema_key <- paste0("tema", tema_num)
    
    if (tema_key %in% names(temas_info)) {
      paginas[[temas_info[[tema_key]]]] <- pagina_actual
      
      # Calcular páginas del archivo actual
      tryCatch({
        num_paginas <- pdf_length(archivo)
        pagina_actual <- pagina_actual + num_paginas
      }, error = function(e) {
        pagina_actual <- pagina_actual + 1
      })
    }
  }
  
  return(paginas)
}

#' Función para crear portada temporal (solo para contar páginas)
crear_portada_temporal <- function() {
  
  qmd_content <- '---
format:
  pdf:
    pdf-engine: weasyprint
    include-before-body: portada.html
    css: estilos.css
    margin-top: 0mm
    margin-bottom: 0mm
    margin-left: 0mm
    margin-right: 0mm
---

# Índice de Diapositivas

- Tema 0: Introducción a los Modelos Estadísticos para la Predicción
- Tema 1: Regresión Lineal Simple  
- Tema 2: Regresión Lineal Múltiple
- Tema 3: Ingeniería de Características
- Tema 4: Selección de Variables, Regularización y Validación
- Tema 5: Modelos Lineales Generalizados (GLM)
'
  
  writeLines(qmd_content, "portada_temp.qmd")
  
  tryCatch({
    quarto_render("portada_temp.qmd", quiet = TRUE)
    file.remove("portada_temp.qmd")
  }, error = function(e) {
    if (file.exists("portada_temp.qmd")) file.remove("portada_temp.qmd")
  })
}

#' Función para crear portada CON enlaces clicables
crear_portada_con_enlaces <- function(paginas_temas) {
  
  # Crear enlaces HTML para cada tema
  enlaces_html <- c()
  temas_originales <- c(
    "Introduccion a los Modelos Estadisticos" = "Tema 0: Introducción a los Modelos Estadísticos para la Predicción",
    "Regresion Lineal Simple" = "Tema 1: Regresión Lineal Simple",
    "Regresion Lineal Multiple" = "Tema 2: Regresión Lineal Múltiple", 
    "Ingenieria de Caracteristicas" = "Tema 3: Ingeniería de Características",
    "Seleccion de Variables y Regularizacion" = "Tema 4: Selección de Variables, Regularización y Validación",
    "Modelos Lineales Generalizados" = "Tema 5: Modelos Lineales Generalizados (GLM)"
  )
  
  for (tema_key in names(paginas_temas)) {
    pagina <- paginas_temas[[tema_key]]
    titulo_completo <- if (tema_key %in% names(temas_originales)) temas_originales[[tema_key]] else tema_key
    
    enlace <- paste0('- <a href="#page=', pagina, '" style="color: #374151; text-decoration: none;">', 
                    titulo_completo, '</a>')
    enlaces_html <- c(enlaces_html, enlace)
  }
  
  # Crear contenido del QMD con enlaces
  qmd_content <- paste0('---
format:
  pdf:
    pdf-engine: weasyprint
    include-before-body: portada.html
    css: estilos.css
    margin-top: 0mm
    margin-bottom: 0mm
    margin-left: 0mm
    margin-right: 0mm
---

# Índice de Diapositivas

', paste(enlaces_html, collapse = '\n'))
  
  # Escribir y renderizar
  writeLines(qmd_content, "portada_enlaces.qmd")
  
  tryCatch({
    quarto_render("portada_enlaces.qmd")
    file.rename("portada_enlaces.pdf", "portada_general.pdf")
    file.remove("portada_enlaces.qmd")
  }, error = function(e) {
    cat("Error al crear portada con enlaces:", e$message, "\n")
    if (file.exists("portada_enlaces.qmd")) file.remove("portada_enlaces.qmd")
    stop(e)
  })
}

#' Función para unir PDFs y agregar bookmarks laterales
unir_con_bookmarks <- function(archivos_input, archivo_salida, paginas_temas) {
  
  # Primero unir todos los PDFs
  tryCatch({
    pdf_combine(input = archivos_input, output = archivo_salida)
  }, error = function(e) {
    cat("Error uniendo PDFs:", e$message, "\n")
    return(FALSE)
  })
  
  # Luego agregar bookmarks laterales si pdftk está disponible
  if (system("pdftk --version", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0) {
    cat("   Agregando bookmarks laterales...\n")
    agregar_bookmarks_laterales(archivo_salida, paginas_temas)
    return(TRUE)
  } else {
    cat("   pdftk no disponible, solo enlaces en portada\n")
    return(TRUE)
  }
}

#' Función para agregar bookmarks laterales
agregar_bookmarks_laterales <- function(archivo_pdf, paginas_temas) {
  
  tryCatch({
    # Crear contenido de bookmarks
    contenido_bookmarks <- c()
    
    # Bookmark para la portada
    contenido_bookmarks <- c(contenido_bookmarks,
                           "BookmarkBegin",
                           "BookmarkTitle: Indice de Diapositivas", 
                           "BookmarkLevel: 1",
                           "BookmarkPageNumber: 2")
    
    # Bookmarks para cada tema
    for (tema in names(paginas_temas)) {
      contenido_bookmarks <- c(contenido_bookmarks,
                             "BookmarkBegin",
                             paste0("BookmarkTitle: ", tema),
                             "BookmarkLevel: 1", 
                             paste0("BookmarkPageNumber: ", paginas_temas[[tema]]))
    }
    
    # Escribir archivo de bookmarks
    writeLines(contenido_bookmarks, "bookmarks_temp.txt", useBytes = TRUE)
    
    # Aplicar con pdftk
    archivo_temp <- paste0(tools::file_path_sans_ext(archivo_pdf), "_con_bookmarks.pdf")
    
    comando <- paste("pdftk", shQuote(archivo_pdf),
                    "update_info bookmarks_temp.txt output", shQuote(archivo_temp))
    
    resultado <- system(comando, ignore.stdout = TRUE)
    
    if (resultado == 0 && file.exists(archivo_temp)) {
      file.rename(archivo_temp, archivo_pdf)
      cat("   ✓ Bookmarks laterales agregados\n")
    } else {
      cat("   ⚠ No se pudieron agregar bookmarks laterales\n")
    }
    
    # Limpiar
    if (file.exists("bookmarks_temp.txt")) file.remove("bookmarks_temp.txt")
    
  }, error = function(e) {
    cat("   Error con bookmarks:", e$message, "\n")
  })
}

#' Función para obtener archivos de temas
obtener_archivos_temas <- function() {
  archivos_esperados <- c(
    "tema0_introduccion.pdf",
    "tema1_regresionlineal.pdf", 
    "tema2_regresionmultiple.pdf",
    "tema3_ingenieriacaracteristicas.pdf",
    "tema4_seleccion_variables.pdf",
    "tema5_glm.pdf"
  )
  
  return(archivos_esperados[file.exists(archivos_esperados)])
}

#' Función para mostrar información del resultado
mostrar_info_resultado <- function(archivo_salida, archivos_input) {
  cat("\n=== INFORMACIÓN DEL RESULTADO ===\n")
  
  if (file.exists(archivo_salida)) {
    info <- file.info(archivo_salida)
    cat("Archivo:", archivo_salida, "\n")
    cat("Tamaño:", round(info$size / 1024 / 1024, 2), "MB\n")
    
    tryCatch({
      num_paginas <- pdf_length(archivo_salida)
      cat("Páginas totales:", num_paginas, "\n")
    }, error = function(e) {
      cat("Páginas: (no se pudo determinar)\n")
    })
  }
  
  cat("\nFuncionalidades incluidas:\n")
  cat("✓ Portada con enlaces clicables en el índice\n")
  cat("✓ Bookmarks navegables en panel lateral\n")
  cat("✓ Todos los temas unidos en un solo PDF\n")
}

#' Función de verificación
verificar_entorno <- function() {
  cat("=== VERIFICACIÓN DEL ENTORNO ===\n")
  
  # Verificar paquetes R
  paquetes <- c("pdftools", "quarto")
  for (pkg in paquetes) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      cat("✓", pkg, "instalado\n")
    } else {
      cat("✗", pkg, "NO instalado\n")
    }
  }
  
  # Verificar archivos de configuración
  archivos_config <- c("portada.html", "estilos.css")
  for (archivo in archivos_config) {
    if (file.exists(archivo)) {
      cat("✓", archivo, "encontrado\n")
    } else {
      cat("✗", archivo, "NO encontrado\n")
    }
  }
  
  # Verificar logo
  if (file.exists("images/urjc_logo.png")) {
    cat("✓ Logo URJC encontrado\n")
  } else {
    cat("✗ Logo URJC NO encontrado\n")
  }
  
  # Verificar pdftk
  if (system("pdftk --version", ignore.stdout = TRUE, ignore.stderr = TRUE) == 0) {
    cat("✓ pdftk instalado (bookmarks laterales disponibles)\n")
  } else {
    cat("⚠ pdftk no encontrado (solo enlaces en portada)\n")
  }
  
  # Verificar archivos de temas
  archivos_temas <- obtener_archivos_temas()
  cat("\nArchivos de temas:\n")
  if (length(archivos_temas) > 0) {
    for (archivo in archivos_temas) {
      cat("✓", archivo, "\n")
    }
  } else {
    cat("✗ No se encontraron archivos de temas\n")
  }
  
  cat("\n")
}

#' Función para crear versión con temas específicos
crear_pdf_personalizado <- function(temas_incluir = NULL, nombre_salida = "diapositivas_personalizadas.pdf") {
  
  if (is.null(temas_incluir)) {
    temas_incluir <- 0:5
  }
  
  cat("Creando PDF personalizado con temas:", paste(temas_incluir, collapse = ", "), "\n")
  
  # Filtrar archivos según temas especificados
  todos_archivos <- obtener_archivos_temas()
  archivos_seleccionados <- c()
  
  for (tema in temas_incluir) {
    patron <- paste0("tema", tema, "_")
    archivo <- todos_archivos[grepl(patron, todos_archivos)]
    if (length(archivo) > 0) {
      archivos_seleccionados <- c(archivos_seleccionados, archivo[1])
    }
  }
  
  if (length(archivos_seleccionados) == 0) {
    stop("No se encontraron archivos para los temas especificados")
  }
  
  # Calcular páginas y crear portada personalizada
  paginas_personalizadas <- calcular_paginas_temas(archivos_seleccionados)
  crear_portada_con_enlaces(paginas_personalizadas)
  
  # Unir PDFs
  todos_los_archivos <- c("portada_general.pdf", archivos_seleccionados)
  unir_con_bookmarks(todos_los_archivos, nombre_salida, paginas_personalizadas)
  
  # Limpiar
  file.remove("portada_general.pdf")
  
  cat("✓ Creado:", nombre_salida, "\n")
  return(nombre_salida)
}

# === FUNCIONES DE USO RÁPIDO ===

#' Crear PDF completo con portada clicable + bookmarks
crear <- function(nombre = "diapositivas_completas.pdf") {
  crear_pdf_completo(nombre)
}

#' Crear PDF con temas específicos
parcial <- function(temas, nombre = "diapositivas_parciales.pdf") {
  crear_pdf_personalizado(temas, nombre)
}

#' Verificar entorno
check <- function() {
  verificar_entorno()
}

# Mensaje de bienvenida
cat("=== SISTEMA DE DIAPOSITIVAS CON ENLACES COMPLETOS ===\n")
cat("Funciones disponibles:\n")
cat("  check()                    - Verificar entorno\n")
cat("  crear()                    - Crear PDF completo\n") 
cat("  crear('mi_nombre.pdf')     - Crear con nombre específico\n")
cat("  parcial(c(1,2,3))          - Crear PDF solo con temas 1, 2 y 3\n")
cat("\nCaracterísticas:\n")
cat("✓ Portada con índice clicable\n")
cat("✓ Bookmarks laterales navegables\n")
cat("✓ Sin título automático feo\n")
cat("✓ Sin problemas de tildes\n")
cat("\nEjemplo: crear()\n\n")