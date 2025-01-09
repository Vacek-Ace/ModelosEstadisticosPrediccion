#' ---
#' title: "Solución EDA1"
#' author: "Isaac Martín"
##' ---

library(ggplot2)
library(dplyr)
library(readr)

# Cargar el conjunto de datos
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00222/bank.zip"
download.file(url, "bank.zip")
unzip("bank.zip", "bank-full.csv")
bank_data <- read.csv("bank-full.csv",sep=";")

# Pregunta 1: Estructura del DataFrame
head(bank_data)
dim(bank_data)

# Pregunta 2: Resumen del DataFrame
summary(bank_data)

# Pregunta 3: Distribución de la Edad
summary(bank_data$age)
ggplot(bank_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +
  labs(title = "Distribución de la Edad de los Clientes",
       x = "Edad",
       y = "Frecuencia") +
  theme_minimal()

# Pregunta 4: Balance Promedio
mean(bank_data$balance, na.rm = TRUE)
mean(bank_data$balance[bank_data$y == "yes"], na.rm = TRUE)

# Pregunta 5: Frecuencia de Contacto
summary(bank_data$campaign)

# Pregunta 6: Análisis de Duración
summary(bank_data$duration)
mean(bank_data$duration[bank_data$y == "yes"], na.rm = TRUE)

# Pregunta 7: Relación entre Balance y Duración
ggplot(bank_data, aes(x = balance, y = duration)) +
  geom_point(alpha = 0.5) +
  labs(title = "Relación entre Balance y Duración del Último Contacto",
       x = "Balance",
       y = "Duración (segundos)") +
  theme_minimal()

# Pregunta 8: Segmentación por Trabajo
bank_data %>% group_by(job) %>%
  summarise(media_balance = mean(balance, na.rm = TRUE),
            mediana_balance = median(balance, na.rm = TRUE))

# Pregunta 9: Análisis de Contactos Anteriores
summary(bank_data$pdays)
mean(bank_data$pdays[bank_data$y == "yes"], na.rm = TRUE)

# Pregunta 10: Estudio General
# Puedes utilizar técnicas de análisis más avanzadas como correlación, regresión, etc.
cor(bank_data$balance, bank_data$duration, use = "complete.obs")
ggplot(bank_data, aes(x = campaign, y = balance)) +
  geom_point(alpha = 0.5) +
  labs(title = "Relación entre Campañas y Balance",
       x = "Número de Campañas",
       y = "Balance") +
  theme_minimal()

