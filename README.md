# Modelos Estadísticos para la Predicción

Este repositorio contiene el material completo del curso de **Modelos Estadísticos para la Predicción**, incluyendo apuntes, diapositivas, ejercicios y laboratorios prácticos.

## 📚 Contenido del Curso

### Temas Principales
- **Tema 0**: Introducción a los Modelos Estadísticos
- **Tema 1**: Regresión Lineal Simple  
- **Tema 2**: Regresión Lineal Múltiple
- **Tema 3**: Ingeniería de Características
- **Tema 4**: Selección de Variables y Regularización
- **Tema 5**: Modelos Lineales Generalizados (GLM)

## 🚀 Generación Automática de Documentos

Este proyecto utiliza **Quarto** y **R** para generar automáticamente todos los documentos en diferentes formatos.

### ⚡ Inicio Rápido

```bash
# Clonar el repositorio
git clone https://github.com/Vacek-Ace/ModelosEstadisticosPrediccion.git
cd ModelosEstadisticosPrediccion

# Instalar dependencias (ver sección de requisitos)
# Ejecutar desde la raíz del proyecto
```

## 📖 Generación de Documentos

### 1. 📑 Diapositivas (PDF)

#### Generar todas las diapositivas automáticamente:
```r
# Ejecutar desde la raíz del proyecto
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"
```

**Características:**
- ✅ Crea automáticamente PDFs faltantes de temas individuales
- ✅ Genera portada automática
- ✅ Bookmarks laterales navegables
- ✅ Unifica todos los temas en un solo PDF
- ✅ Guarda en `diapositivas/diapositivas_pdf/diapositivas_completas.pdf`

#### Otras opciones disponibles:
```r
# Verificar entorno antes de ejecutar
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); check()"

# Crear solo algunos temas (ej: temas 1, 2 y 3)
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); parcial(c(1,2,3))"

# Crear con nombre personalizado
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear('mi_diapositivas.pdf')"
```

### 2. 📚 Libro de Apuntes

#### HTML (recomendado):
```bash
quarto render --to html
```
- Genera el libro completo en HTML navegable
- Salida en el directorio `docs/` 
- Incluye navegación interactiva y buscador
- Perfecto para consulta online

#### PDF (con portada y formato profesional):
```bash
Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"
```
- Genera un PDF unificado con portada personalizada
- Remueve páginas duplicadas automáticamente
- Salida en `apuntes/apuntes_pdf/ModelosEstadisticosPrediccion.pdf`
- Requiere LaTeX y PDFtk instalados


### 3. 🧮 Ejercicios

#### Generar todos los ejercicios:
```bash
cd ejercicios
quarto render
```

#### PDF específico:
```bash
cd ejercicios
quarto render --to pdf --output-dir ejercicios_pdf
```

**Contenido:**
- Ejercicios por cada tema  
- Ejercicios de repaso general con soluciones
- Material de práctica adicional

### 4. 📋 Guía de Estudio

#### Generar guía PDF:
```bash
cd guia_estudio
quarto render guia_estudio.qmd --to pdf
```

**Características:**
- Resumen ejecutivo de todos los temas
- Puntos clave para estudio
- Preparación para exámenes
- Formato compacto y portable

### 5. 🔬 Laboratorios

Los laboratorios se pueden ejecutar individualmente:

```bash
# Laboratorio específico
quarto render laboratorios/lab1_regresion_simple.qmd

# Todos los laboratorios
quarto render laboratorios/
```

**Laboratorios disponibles:**
- `lab0_introduccion.qmd` - Introducción a R y herramientas
- `lab1_regresion_simple.qmd` - Regresión lineal simple
- `lab2_regresion_multiple.qmd` - Regresión múltiple  
- `lab3_ingenieria_caracteristicas.qmd` - Transformación de variables
- `lab4_seleccion_variables.qmd` - Selección y validación
- `lab5_modelos_generalizados.qmd` - GLM

## 🔧 Requisitos del Sistema

### Software Necesario

1. **R (4.0+)**
   ```r
   # Paquetes requeridos
   install.packages(c("quarto", "pdftools", "knitr", "rmarkdown"))
   ```

2. **Quarto CLI**
   - Descargar desde: https://quarto.org/docs/get-started/
   - Verificar instalación: `quarto --version`

3. **LaTeX (para PDFs)**
   - **Windows**: MiKTeX o TeX Live
   - **macOS**: MacTeX
   - **Linux**: TeX Live
   
   O usar TinyTeX desde R:
   ```r
   quarto::quarto_install_tinytex()
   ```

4. **PDFtk (opcional, para bookmarks avanzados)**
   - **Windows**: Descargar desde https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
   - **macOS**: `brew install pdftk-java`
   - **Linux**: `sudo apt-get install pdftk`

### Dependencias de R

```r
# Paquetes principales
install.packages(c(
  "quarto",           # Renderizado de documentos
  "pdftools",         # Manipulación de PDFs
  "knitr",            # Generación de reportes
  "rmarkdown",        # Markdown con R
  "ggplot2",          # Gráficos
  "dplyr",            # Manipulación de datos
  "readr",            # Lectura de datos
  "here"              # Gestión de rutas
))
```

## 📁 Estructura del Proyecto

```
ModelosEstadisticosPrediccion/
├── _quarto.yml                    # Configuración principal de Quarto
├── README.md                      # Este archivo
├── estilos.css                    # Estilos personalizados
│
├── index.qmd                      # Página principal del libro
├── tema0.qmd - tema5.qmd         # Capítulos principales
├── conclusiones.qmd              # Conclusiones del curso
├── references.qmd                # Referencias bibliográficas
│
├── apuntes/                      # Generación de libro PDF
│   ├── generar_libro.R           # Script para libro PDF profesional
│   ├── portada.qmd               # Portada del libro
│   └── apuntes_pdf/              # PDFs generados
│       └── ModelosEstadisticosPrediccion.pdf
│
├── diapositivas/                 # Diapositivas de clase
│   ├── crear_diapositivas_completas.R  # Script automatizado
│   ├── portada.qmd               # Portada de diapositivas
│   ├── tema0_introduccion.qmd    # Diapositivas por tema
│   └── diapositivas_pdf/         # PDFs generados
│       └── diapositivas_completas.pdf
│
├── ejercicios/                   # Ejercicios y soluciones
│   ├── _quarto.yml              # Configuración específica
│   ├── index.qmd                # Índice de ejercicios
│   ├── tema1_regresion_simple.qmd
│   ├── popurri.qmd              # Ejercicios de repaso general
│   ├── popurri_soluciones.qmd   # Soluciones del repaso
│   └── ejercicios_pdf/          # PDFs generados
│
├── guia_estudio/                # Guía de estudio compacta
│   ├── guia_estudio.qmd         # Guía principal
│   ├── portada.html             # Portada de la guía
│   └── guia_estudio.pdf         # PDF generado
│
├── laboratorios/                # Labs prácticos
│   ├── lab0_introduccion.qmd
│   ├── lab1_regresion_simple.qmd
│   └── ...
│
├── images/                      # Imágenes y logos
├── intro/                       # Material introductorio  
└── docs/                       # Libro HTML generado
```

## 🎯 Flujos de Trabajo Comunes

### Para el Docente

```bash
# 1. Actualizar todo el contenido automáticamente
quarto render                     # Libro HTML
Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"  # Libro PDF profesional
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"  # Diapositivas
cd ejercicios && quarto render --to pdf  # Ejercicios
cd ../guia_estudio && quarto render guia_estudio.qmd --to pdf  # Guía de estudio

# 2. Solo actualizar diapositivas para clase
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"
```

### Para el Estudiante

```bash
# 1. Generar libro de estudio (HTML navegable)
quarto render

# 2. Generar libro PDF para imprimir
Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"

# 3. Generar guía de estudio compacta
cd guia_estudio && quarto render guia_estudio.qmd --to pdf

# 4. Generar ejercicios para imprimir  
cd ejercicios
quarto render --to pdf
```

## 🐛 Solución de Problemas

### Errores Comunes

1. **Error: "quarto not found"**
   ```bash
   # Verificar instalación
   quarto --version
   # Reinstalar si es necesario
   ```

2. **Error en PDFs: "LaTeX Error"**
   ```r
   # Instalar TinyTeX
   quarto::quarto_install_tinytex()
   ```

3. **Error: "File not found" en diapositivas**
   ```bash
   # Ejecutar desde la raíz del proyecto
   pwd  # Debe mostrar ModelosEstadisticosPrediccion
   ```

4. **Problemas con imágenes**
   - Verificar que las rutas en los archivos QMD sean relativas al archivo
   - Asegurar que las imágenes existan en el directorio `images/`

### Verificación del Entorno

```r
# Verificar setup completo
source('diapositivas/crear_diapositivas_completas.R')
check()
```

## 📄 Licencia

Este material está licenciado bajo [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## 👥 Autores

- **Víctor Aceña** - [GitHub](https://github.com/Vacek-Ace)
- **Isaac Martín** - DSLAB

---

## 🚀 ¡Empezar Ahora!

1. **Clonar** el repositorio
2. **Verificar** requisitos con `source('diapositivas/crear_diapositivas_completas.R'); check()`
3. **Generar** todo con `quarto render`
4. **¡Listo!** Navegar a `docs/index.html`

Para soporte adicional, consultar la [documentación de Quarto](https://quarto.org/docs/) o abrir un issue en el repositorio.

## 📝 Notas de Organización

### Sugerencias de Mejora en Nomenclatura

Para una mejor organización y claridad, se recomienda renombrar los siguientes archivos:

```bash
# En el directorio ejercicios/
mv popurri.qmd ejercicios_repaso_general.qmd
mv popurri_soluciones.qmd ejercicios_repaso_general_soluciones.qmd
```

Esto haría los nombres más descriptivos y profesionales, reemplazando "popurrí" por "repaso general".

## 📄 Licencia

Este material está licenciado bajo [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## 👥 Autores

- **Víctor Aceña** - [GitHub](https://github.com/Vacek-Ace)
- **Isaac Martín** - DSLAB