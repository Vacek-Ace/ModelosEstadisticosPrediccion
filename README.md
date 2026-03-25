# Modelos Estadísticos para la Predicción

Este repositorio contiene el material completo del curso de **Modelos Estadísticos para la Predicción**, incluyendo apuntes, diapositivas, ejercicios, soluciones y laboratorios prácticos.

Depositado en burjcdigital: https://hdl.handle.net/10115/103057 (2025-09-24)

Código fuente preservado en Software Heritage para garantizar el acceso abierto y la
reproducibilidad.

<a href="https://archive.softwareheritage.org/swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478;origin=https://github.com/URJCDSLab/ModelosEstadisticosPrediccion;visit=swh:1:snp:f41a70a106d5f90b6ddd40440bc7d51fdd5d44b7;anchor=swh:1:rev:cc85115fd6a3487169464d1b7e7d815ed0e270cf"><img src="https://archive.softwareheritage.org/badge/swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478/" alt="Archived | swh:1:dir:e347e182ad5c23fdf7f3cacff0ec657dc3231478"/></a>



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

### 1. 📚 Apuntes

#### HTML (recomendado):
```bash
quarto render --to html
```
- Genera los apuntes completos en HTML navegable
- Salida en el directorio `docs/` 
- Incluye navegación interactiva y buscador
- Perfecto para consulta online

#### PDF (con portada y formato profesional):
```bash
Rscript -e "source('apuntes/generar_apuntes.R'); crear_libro_completo()"
```
- Genera un PDF unificado con portada personalizada
- Remueve páginas duplicadas automáticamente
- Salida en `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf`
- Requiere LaTeX y PDFtk instalados

### 2. 📑 Diapositivas (PDF)

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
- ✅ Guarda en `diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf`

#### Otras opciones disponibles:
```r
# Verificar entorno antes de ejecutar
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); check()"

# Crear solo algunos temas (ej: temas 1, 2 y 3)
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); parcial(c(1,2,3))"

# Crear con nombre personalizado
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear('mi_diapositivas.pdf')"
```

### 3. 🧮 Ejercicios

#### Generar ejercicios completos con portada personalizada y fórmulas LaTeX:
```r
# Ejecutar desde la raíz del proyecto
Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"
```

#### Solo HTML (sin portada personalizada):
```bash
cd ejercicios
quarto render
```

**Características:**
- Portada personalizada igual que el libro principal
- Fórmulas LaTeX renderizadas correctamente
- Ejercicios por cada tema  
- Ejercicios avanzados con demostraciones matemáticas
- Archivo final: `ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf`

### 4. 📋 Guía de Estudio

#### Generar guía PDF con portada personalizada (recomendado):
```r
# Ejecutar desde la raíz del proyecto
Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"
```

#### Generar guía PDF básica (usando configuración original):
```bash
cd guia_estudio
quarto render guia_estudio.qmd --to pdf
```

**Características:**
- **Método 1**: Portada personalizada separada + contenido con LaTeX (mejor calidad)
- **Método 2**: Todo-en-uno con WeasyPrint (más simple, menos opciones de formato)
- Resumen ejecutivo de todos los temas
- Puntos clave para estudio
- Preparación para exámenes
- Archivo final (Método 1): `guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf`
- Archivo final (Método 2): `guia_estudio/guia_estudio.pdf`

### 5. ✅ Soluciones de Ejercicios

El proyecto incluye **dos sistemas de soluciones** independientes:

#### 📁 Sistema `ejercicios/soluciones/` - Soluciones en proceso de desarrollo

Este directorio contiene las primeras versiones de las soluciones.

```bash
# Generar soluciones HTML
cd ejercicios/soluciones
quarto render --to html

# Usar el script R para más opciones
Rscript -e "source('ejercicios/soluciones/generar_soluciones.R'); generar_todas_soluciones()"
```

#### 📁 Sistema `ejercicios_resueltos/` - Soluciones completas y definitivas ⭐

Este directorio contiene las soluciones **completas y validadas** con portada profesional.

```bash
# HTML (recomendado para consulta)
Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); generar_todas_soluciones()"

# PDF completo con portada profesional
Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); crear_soluciones_completas()"

# Solución específica
Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); generar_solucion(1)"

# Abrir en navegador
Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); abrir_soluciones()"
```

**Características de las soluciones definitivas:**
- ✅ **PDF profesional** con portada personalizada y manipulación avanzada de PDFs
- ✅ **HTML navegable** con diseño responsivo y tema cerulean
- ✅ Código R completo y comentado paso a paso
- ✅ Explicaciones matemáticas detalladas con derivaciones
- ✅ Interpretaciones prácticas de todos los resultados
- ✅ Secciones colapsibles para mejor navegación
- ✅ Styling profesional y consistente
- ✅ Validación completa de código con ejemplos reales
- ✅ Seguimiento del patrón profesional del proyecto

**Soluciones disponibles:**
- `tema1_regresion_simple_soluciones.qmd` - Regresión lineal simple con análisis completo
- `tema2_regresion_multiple_soluciones.qmd` - Regresión múltiple y diagnósticos
- `tema3_ingenieria_caracteristicas_soluciones.qmd` - Transformación de variables
- `tema4_seleccion_validacion_soluciones.qmd` - Selección de variables y validación cruzada
- `tema5_glm_soluciones.qmd` - Modelos lineales generalizados (logística, Poisson)
- `ejercicios_avanzados_soluciones.qmd` - Demostraciones matemáticas y derivaciones teóricas

📁 **Archivos generados:**
- HTML: `ejercicios_resueltos/soluciones_html/`
- PDF: `ejercicios_resueltos/soluciones_pdf/SolucionesModelosEstadisticosPrediccion.pdf`

### 6. 🔬 Laboratorios

Esta sección constituye el núcleo aplicativo del proyecto. Se compone de 6 programas independientes desarrollados en Quarto (.qmd), que cubren el flujo completo de análisis estadístico, desde la configuración inicial hasta el despliegue de modelos complejos.

🚀 **Ejecución**

Los laboratorios se pueden ejecutar individualmente:

```bash
# Laboratorio específico
quarto render laboratorios/lab1_regresion_simple.qmd

# Todos los laboratorios
quarto render laboratorios/
```

📚 **Contenido Detallado**

| Laboratorio | Enfoque Técnico | Conceptos Clave |
| :--- | :--- | :--- |
| **Lab 0** | Introducción | Configuración de entorno en R y flujo de trabajo con Quarto. |
| **Lab 1** | Regresión Simple | Estimación de parámetros y diagnóstico fundamental del modelo. |
| **Lab 2** | Regresión Múltiple | Inferencia multivariante, análisis de residuos y detección de colinealidad (**VIF**). |
| **Lab 3** | Feature Engineering | Transformaciones no lineales (**Box-Cox**, log) y tratamiento de predictores categóricos. |
| **Lab 4** | Selección de Modelos | Selección de predictores y regularización avanzada (**Lasso** y **Ridge**). |
| **Lab 5** | Modelos GLM | Modelado de respuestas no normales: Regresión **Logística** y de **Poisson**. |

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

## 📋 Archivos Finales Generados

Todos los archivos PDF finales siguen la nomenclatura estandarizada:

| Contenido | Comando | Archivo Final |
|-----------|---------|---------------|
| **Apuntes** | `Rscript -e "source('apuntes/generar_apuntes.R'); crear_libro_completo()"` | `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf` |
| **Diapositivas** | `Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"` | `diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf` |
| **Ejercicios** | `Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"` | `ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf` |
| **Soluciones** | `Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); crear_soluciones_completas()"` | `ejercicios_resueltos/soluciones_pdf/SolucionesModelosEstadisticosPrediccion.pdf` |
| **Guía de Estudio** | `Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"` | `guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf` |

**Características comunes:**
- ✅ Portadas personalizadas con diseño unificado
- ✅ Fórmulas LaTeX renderizadas correctamente  
- ✅ Tabla de contenidos navegable
- ✅ Formato profesional consistente
- ✅ Optimizados para impresión y distribución

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
├── _quarto.yml                               # Configuración principal del libro
├── index.qmd                                # Página principal
├── tema*.qmd                                # Contenido de cada tema (0-5)
├── conclusiones.qmd                         # Conclusiones del curso
├── references.qmd                           # Referencias bibliográficas
├── references.bib                           # Base de datos bibliográfica
├── estilos.css / estilos_html.css          # Estilos personalizados
│
├── docs/                                   # 📖 LIBRO WEB (salida HTML)
│   ├── index.html                         # Página principal del libro web
│   ├── tema*.html                         # Temas en formato web
│   ├── search.json                        # Índice de búsqueda
│   └── site_libs/                         # Librerías de Quarto para web
│
├── apuntes/                               # 📚 GENERACIÓN DE APUNTES PDF
│   ├── generar_apuntes.R                  # Script principal para PDFs
│   ├── portada.qmd                        # Portada personalizada
│   └── apuntes_pdf/                       # 📋 Salida de apuntes
│       └── ApuntesModelosEstadisticosPrediccion.pdf
│
├── diapositivas/                          # 📊 DIAPOSITIVAS BEAMER
│   ├── tema*_*.qmd                        # Diapositivas por tema
│   ├── crear_diapositivas_completas.R     # Script de generación automática
│   ├── beamercolorthemeDSLAB.sty         # Tema personalizado Beamer
│   ├── dslab_fixed.beamer.tex            # Template LaTeX
│   ├── portada.qmd                        # Portada de diapositivas
│   └── diapositivas_pdf/                  # 📋 Salida de diapositivas
│       └── DiapositivasModelosEstadisticosPrediccion.pdf
│
├── ejercicios/                            # 💪 EJERCICIOS PRÁCTICOS
│   ├── _quarto.yml                        # Configuración específica
│   ├── tema*_*.qmd                        # Ejercicios por tema
│   ├── ejercicios_avanzados.qmd          # Ejercicios avanzados
│   ├── generar_ejercicios.R              # Script de generación PDF
│   ├── portada.qmd                        # Portada de ejercicios
│   └── ejercicios_pdf/                    # 📋 Salida de ejercicios
│       └── EjerciciosModelosEstadisticosPrediccion.pdf
│
├── ejercicios_resueltos/                  # ✅ SOLUCIONES COMPLETAS ⭐
│   ├── _quarto.yml                        # Configuración para HTML y PDF
│   ├── tema*_*_soluciones.qmd            # Soluciones detalladas por tema
│   ├── ejercicios_avanzados_soluciones.qmd # Soluciones de ejercicios avanzados
│   ├── soluciones_globales.qmd           # Página índice de soluciones
│   ├── generar_soluciones.R              # Script completo de generación
│   ├── portada.qmd                        # Portada para PDF (weasyprint)
│   ├── portada.html                       # Portada HTML para inclusión
│   ├── collapse-handler.js               # JavaScript para secciones colapsables
│   ├── soluciones.css                     # Estilos específicos para soluciones
│   ├── soluciones_html/                   # 📋 Salida HTML navegable
│   │   ├── index.html                     # Índice principal de soluciones
│   │   └── tema*_*_soluciones.html       # Soluciones individuales
│   └── soluciones_pdf/                    # 📋 Salida PDF profesional
│       └── SolucionesModelosEstadisticosPrediccion.pdf
│
├── guia_estudio/                          # 📖 GUÍA DE ESTUDIO
│   ├── guia_estudio.qmd                   # Contenido de la guía
│   ├── generar_guia.R                     # Script de generación
│   ├── portada.html                       # Portada personalizada
│   └── GuiaEstudioModelosEstadisticosPrediccion.pdf
│
├── laboratorios/                          # 🔬 LABORATORIOS PRÁCTICOS
│   ├── lab*_*.qmd                         # Laboratorios por tema
│   └── (salida HTML individual por laboratorio)
│
├── libro/                                 # 📘 LIBRO COMPLETO (PDF)
│   ├── generar_libro_final.R              # Script principal que combina todos los PDFs en un 
│   └── LibroCompletoModelosEstadisticosPrediccion.pdf  # Archivo PDF resultante
│
└── images/                                # 🖼️ RECURSOS GRÁFICOS
    ├── DSLab_logo_*.png                   # Logos institucionales
    ├── URJC_logo.png                      # Logo universidad
    └── (otras imágenes del curso)
```

### 🎯 Puntos de Entrada Principales

| **Propósito** | **Comando de Generación** | **Archivo Final** |
|---------------|----------------------------|-------------------|
| **Libro Web** | `quarto render --to html` | `docs/index.html` |
| **Apuntes PDF** | `Rscript -e "source('apuntes/generar_apuntes.R'); crear_apuntes_completo()"` | `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf` |
| **Diapositivas** | `Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"` | `diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf` |
| **Ejercicios** | `Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"` | `ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf` |
| **Soluciones HTML** | `Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); generar_todas_soluciones()"` | `ejercicios_resueltos/soluciones_html/index.html` |
| **Soluciones PDF** | `Rscript -e "source('ejercicios_resueltos/generar_soluciones.R'); crear_soluciones_completas()"` | `ejercicios_resueltos/soluciones_pdf/SolucionesModelosEstadisticosPrediccion.pdf` |
| **Guía Estudio** | `Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"` | `guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf` |

### 📝 Scripts de Generación Automática

El proyecto incluye **6 scripts principales** que automatizan completamente la generación:

1. **`apuntes/generar_apuntes.R`** - Libro PDF con portada profesional
2. **`diapositivas/crear_diapositivas_completas.R`** - Diapositivas unificadas con bookmarks
3. **`ejercicios/generar_ejercicios.R`** - Ejercicios PDF con portada y LaTeX
4. **`ejercicios_resueltos/generar_soluciones.R`** - Soluciones HTML y PDF completas ⭐
5. **`guia_estudio/generar_guia.R`** - Guía de estudio con portada
6. **Quarto nativo** - Libro web y laboratorios individuales

## 📕 Libro Completo del Curso

Genera el libro PDF profesional con portada, índice, apuntes, diapositivas, ejercicios y guía de estudio, todo unificado y con bookmarks principales:

```bash
# Ejecutar desde la raíz del proyecto
Rscript libro/generar_libro_final.R
```
- Salida: `libro/LibroCompletoModelosEstadisticosPrediccion.pdf`
- Incluye portada, índice, guía, apuntes, diapositivas y ejercicios
- Bookmarks principales para cada sección
- Requiere R, Quarto, LaTeX y PDFtk instalados

### Requisitos previos y orden de generación

Antes de ejecutar `Rscript libro/generar_libro_final.R` asegúrate de que todos los PDFs parciales (apuntes, diapositivas, ejercicios, guía) ya estén generados. El script asume que existen los archivos finales y los combinará en el PDF maestro; si faltan, la ejecución fallará.

Archivos que deben existir (rutas relativas al repositorio):

- `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf`
- `diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf`
- `ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf`
- `guia_estudio/GuiaEstudioModelosEstadisticosPrediccion.pdf`

Comando recomendado (orden de generación):

```bash
# 1. Generar apuntes PDF
Rscript -e "source('apuntes/generar_apuntes.R'); crear_apuntes_completo()"

# 2. Generar diapositivas unificadas
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"

# 3. Generar ejercicios
Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"

# 4. Generar guía de estudio
Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"

# 5. Finalmente, combinar todo en el libro completo
Rscript libro/generar_libro_final.R
```

Comprobación rápida (PowerShell):

```powershell
# Desde la raíz del proyecto
Test-Path .\apuntes\apuntes_pdf\ApuntesModelosEstadisticosPrediccion.pdf; \
Test-Path .\diapositivas\diapositivas_pdf\DiapositivasModelosEstadisticosPrediccion.pdf; \
Test-Path .\ejercicios\ejercicios_pdf\EjerciciosModelosEstadisticosPrediccion.pdf; \
Test-Path .\guia_estudio\GuiaEstudioModelosEstadisticosPrediccion.pdf
```

Notas:
- Si usas Windows y no tienes `pdftk`, la generación del archivo maestro seguirá funcionando (se combina con `pdftools::pdf_combine`) pero no se agregarán bookmarks personalizados; instala `pdftk` para añadir bookmarks.
- Si alguno de los scripts individuales usa Quarto/LaTeX, asegúrate de tener LaTeX (MiKTeX/TinyTeX) configurado previamente.

## 🎨 Características Técnicas

### Diseño y Estilos
- **Diseño unificado** con logo institucional (DSLAB + URJC)
- **Paleta de colores consistente** (azul URJC #003366)
- **Tipografía profesional** con fuentes system-ui optimizadas
- **Responsive design** para dispositivos móviles

### Funcionalidades Avanzadas
- **Búsqueda integrada** en el libro web
- **Navegación por bookmarks** en PDFs
- **Secciones colapsables** en soluciones HTML
- **Fórmulas LaTeX** renderizadas correctamente
- **Código R ejecutable** con salidas incluidas
- **Enlaces cruzados** entre secciones

### Optimizaciones
- **PDFs optimizados** para impresión y distribución
- **HTML auto-contenido** (embed-resources) para distribución offline
- **Manipulación avanzada de PDFs** con portadas separadas
- **Control de calidad** con validación automática de código

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

---

## 📄 Licencia

Este material está licenciado bajo [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## 👥 Autores

- **Víctor C. Aceña Gil** - [GitHub](https://github.com/Vacek-Ace)
- **Isaac Martín de Diego** - [GitHub](https://github.com/IsaacMartindeDiego)
