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
Rscript -e "source('apuntes/generar_apuntes.R'); crear_libro_completo()"
```
- Genera un PDF unificado con portada personalizada
- Remueve páginas duplicadas automáticamente
- Salida en `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf`
- Requiere LaTeX y PDFtk instalados


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

## 📋 Archivos Finales Generados

Todos los archivos PDF finales siguen la nomenclatura estandarizada:

| Contenido | Comando | Archivo Final |
|-----------|---------|---------------|
| **Apuntes** | `Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"` | `apuntes/apuntes_pdf/ApuntesModelosEstadisticosPrediccion.pdf` |
| **Diapositivas** | `Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"` | `diapositivas/diapositivas_pdf/DiapositivasModelosEstadisticosPrediccion.pdf` |
| **Ejercicios** | `Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"` | `ejercicios/ejercicios_pdf/EjerciciosModelosEstadisticosPrediccion.pdf` |
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
├── _quarto.yml                    # Configuración principal de Quarto
├── README.md                      # Este archivo
├── estilos.css                    # Estilos personalizados
│
├── index.qmd                     # Página principal del libro
├── tema0.qmd - tema5.qmd         # Capítulos principales
├── conclusiones.qmd              # Conclusiones del curso
├── references.qmd                # Referencias bibliográficas
│
├── apuntes/                      # Generación de apuntes PDF
│   ├── generar_apuntes.R         # Script para apuntes PDF profesional
│   ├── portada.qmd               # Portada de los apuntes
│   └── apuntes_pdf/              # PDFs generados
│       └── ApuntesModelosEstadisticosPrediccion.pdf
│
├── diapositivas/                 # Diapositivas de clase
│   ├── crear_diapositivas_completas.R  # Script automatizado
│   ├── portada.qmd               # Portada de diapositivas
│   ├── tema**.qmd                # Diapositivas por tema
│   └── diapositivas_pdf/         # PDFs generados
│       └── DiapositivasModelosEstadisticosPrediccion.pdf
│
├── ejercicios/                  # Ejercicios
│   ├── _quarto.yml              # Configuración específica
│   ├── generar_ejercicios.R     # Script para ejercicios PDF profesional
│   ├── index.qmd                # Índice de ejercicios
│   ├── tema**.qmd               # Ejercicios por tema
│   ├── ejercicios_avanzados.qmd # Ejercicios avanzados con matemáticas
│   ├── ejercicios_avanzados_soluciones.qmd   # Soluciones avanzadas
│   └── ejercicios_pdf/          # PDFs generados
│       └── EjerciciosModelosEstadisticosPrediccion.pdf
│
├── guia_estudio/                # Guía de estudio compacta
│   ├── generar_guia.R           # Script para guía PDF profesional
│   ├── guia_estudio.qmd         # Guía principal
│   ├── portada.html             # Portada de la guía
│   ├── guia_estudio.pdf         # PDF básico generado
│   └── GuiaEstudioModelosEstadisticosPrediccion.pdf  # PDF con portada profesional
│
├── laboratorios/                # Labs prácticos
│   ├── lab0_introduccion.qmd
│   ├── lab1_regresion_simple.qmd
│   └── ...
│
├── images/                      # Imágenes y logos
├── intro/                       # Material introductorio  
└── docs/                        # Libro HTML generado
```

## 🎯 Flujos de Trabajo Comunes

### Para el Docente

```bash
# 1. Actualizar todo el contenido automáticamente
quarto render --to html                  # Libro HTML
Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"  # Libro PDF profesional
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"  # Diapositivas
Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"  # Ejercicios
Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"  # Guía de estudio
cd laboratorios && quarto render --to html  # Laboratorios

# 2. Solo actualizar diapositivas para clase
Rscript -e "source('diapositivas/crear_diapositivas_completas.R'); crear()"
```

### Para el Estudiante

```bash
# 1. Generar libro de estudio (HTML navegable)
quarto render --to html

# 2. Generar libro PDF para imprimir
Rscript -e "source('apuntes/generar_libro.R'); crear_libro_completo()"

# 3. Generar guía de estudio compacta
Rscript -e "source('guia_estudio/generar_guia.R'); crear_guia_completa()"

# 4. Generar ejercicios para imprimir  
Rscript -e "source('ejercicios/generar_ejercicios.R'); crear_ejercicios_completos()"

# 5. Generar laboratorios interactivos
cd laboratorios
quarto render --to html
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

- **Víctor C. Aceña Gil** - [GitHub](https://github.com/Vacek-Ace)
- **Isaac Martín de Diego** - DSLAB

---

## 🚀 ¡Empezar Ahora!

1. **Clonar** el repositorio
2. **Verificar** requisitos con `source('diapositivas/crear_diapositivas_completas.R'); check()`
3. **Generar** todo con `quarto render`
4. **¡Listo!** Navegar a `docs/index.html`

Para soporte adicional, consultar la [documentación de Quarto](https://quarto.org/docs/) o abrir un issue en el repositorio.

## 📄 Licencia

Este material está licenciado bajo [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## 👥 Autores

- **Víctor Aceña** - [GitHub](https://github.com/Vacek-Ace)
- **Isaac Martín** - DSLAB