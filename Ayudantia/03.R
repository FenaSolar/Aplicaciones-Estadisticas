# AYUDANTÍA 03 - REGRESIÓN LINEAL SIMPLE CON PINGÜINOS
# Curso: Aplicaciones Estadísticas
# ================================================

# -------------------------------
# Cargar paquetes necesarios
# -------------------------------

library(readr)       # Para leer archivos CSV
library(tidyverse)   # Conjunto de paquetes para manipulación y visualización de datos

# -------------------------------
# Lectura de datos desde archivo CSV
# -------------------------------

# Cambiar el nombre o la ruta del archivo si es necesario
penguins <- read_csv("Data/penguins.csv")

# -------------------------------
# Revisión general y limpieza de datos
# -------------------------------

glimpse(penguins)  # Estructura de la base de datos

# Eliminar filas con valores faltantes (NA) en variables relevantes
penguins_sin_na <- na.omit(penguins)

# -------------------------------
# Análisis descriptivo básico
# -------------------------------

summary(penguins_sin_na$flipper_length_mm)  # Resumen estadístico de longitud de aleta
summary(penguins_sin_na$body_mass_g)        # Resumen estadístico de masa corporal

# -------------------------------
# Visualización exploratoria
# -------------------------------

# Gráfico de dispersión: relación entre longitud de aleta y masa corporal
ggplot(penguins_sin_na, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species)) + 
  theme_minimal()

# -------------------------------
# Ajuste del modelo de regresión lineal simple
# -------------------------------

# Objetivo: evaluar si la longitud de la aleta ('flipper_length_mm')
# explica la variación en la masa corporal ('body_mass_g')
# H0: No hay relación entre ambas variables
# Ha: Sí existe relación significativa

modelo1 <- lm(body_mass_g ~ flipper_length_mm, data = penguins_sin_na)

# -------------------------------
# Resumen del modelo
# -------------------------------

summary(modelo1)  

# Interpretación esperada:
# - Coeficiente de 'flipper_length_mm': cambio esperado en la masa corporal
#   por cada mm adicional de longitud de aleta.
# - R²: porcentaje de variación en masa corporal explicado por el modelo.
# - p-valor: evidencia estadística sobre la relación entre las variables.

# -------------------------------
# Análisis de residuos
# -------------------------------

# Gráfico de residuos vs valores ajustados
plot(modelo1, which = 1)

# QQ-plot para verificar normalidad de los residuos
plot(modelo1, which = 2)

# Tabla ANOVA para el modelo
anova(modelo1)
