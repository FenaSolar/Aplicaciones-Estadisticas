# AYUDANTÍA 04 - CORRELACIÓN Y MATRICES DE CORRELACIÓN
# Curso: Aplicaciones Estadísticas
# ================================================

# -------------------------------
# Cargar paquetes necesarios
# -------------------------------

library(datos)       # Contiene datasets como 'millas'
library(tidyverse)   # Para manipulación y visualización de datos
library(ggcorrplot)  # Para graficar matrices de correlación

# -------------------------------
# Dataset 'millas'
# -------------------------------

# Explorar el dataset
millas
?millas         # Documentación del dataset
glimpse(millas) # Estructura de la base de datos

# -------------------------------
# Relación entre ciudad y autopista
# -------------------------------

ggplot(millas, aes(x = ciudad, y = autopista)) +
  geom_point() + 
  geom_smooth(method = "lm") +  # Línea de regresión lineal
  theme_minimal() +
  labs(title = "Correlación entre consumo en ciudad y autopista")

# -------------------------------
# Calcular correlación entre ciudad y autopista
# -------------------------------

cor.test(millas$ciudad, millas$autopista)

# -------------------------------
# Selección de variables numéricas y matriz de correlación
# -------------------------------

numericas <- millas %>%
  select(ciudad, autopista, cilindrada, cilindros)

cor_matrix <- cor(numericas, use = "complete.obs")
cor_matrix  # Imprime la matriz de correlación

# -------------------------------
# Visualización de la matriz de correlación
# -------------------------------

ggcorrplot(cor_matrix,
           lab = TRUE, 
           type = "lower")  # Solo muestra la mitad inferior

# -------------------------------
# Ejemplo adicional: datos de aeropuerto
# -------------------------------

# Lectura de datos
aeropuerto <- read.csv("data/05_datos_2023_10min_aeropuerto.csv")

# Selección de variables numéricas (se excluyen variables no relevantes)
aer_cor <- aeropuerto %>%
  select(-c(FechaHora_10min, codigoNacional.x, idEquipo.x, 
            codigoNacional.y, idEquipo.y, Altura))

# Cálculo de matriz de correlación
cor_matrix_aer <- cor(aer_cor, use = "complete.obs")
cor_matrix_aer

# Visualización
ggcorrplot(cor_matrix_aer, 
           lab = TRUE, 
           type = "lower",    # Solo muestra la mitad inferior
           lab_size = 2.5)
