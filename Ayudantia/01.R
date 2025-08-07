# AYUDANTÍA 01 - Introducción a objetos en R, manipulación de datos y análisis estadístico básico

# -------------------------------
# Asignación de valores numéricos
# -------------------------------

a <- 10  # Se le asigna el número 10 al objeto 'a' (tipo numérico)
b <- 12  # Se le asigna el número 12 al objeto 'b' (tipo numérico)
c <- a + b  # Se suman los objetos 'a' y 'b', y el resultado se guarda en 'c'

# -------------------------------
# Objetos tipo texto (caracteres)
# -------------------------------

nombre <- "fernando"  # Se asigna un texto al objeto 'nombre' (tipo character)
a1 <- "10"  # Aunque parece un número, el uso de comillas lo convierte en texto (character)

c1 <- b + a1  # Intento de sumar un número con un texto → genera un error

# NOTA: No se pueden realizar operaciones matemáticas entre números y texto

# -------------------------------
# Objetos lógicos (booleanos)
# -------------------------------

d <- TRUE  # Se asigna un valor lógico al objeto 'd' (puede ser TRUE o FALSE)

# -------------------------------
# Verificación de clases de objetos
# -------------------------------

class(a)   # Devuelve "numeric"
class(a1)  # Devuelve "character"
class(d)   # Devuelve "logical"

# -------------------------------
# Eliminar objetos del entorno
# -------------------------------

rm(d)  # Elimina el objeto 'd'
rm(c)  # Elimina el objeto 'c'
rm(b)  # Elimina el objeto 'b'

# -------------------------------
# Vectores
# -------------------------------

edad <- c(23, 24, 25)  # Se crea un vector numérico con la función c()
nombres <- c("fernando", "francisco", "javier")  # Vector de texto (character)

# -------------------------------
# Data frame (estructura tipo tabla)
# -------------------------------

df <- data.frame(
  ID = 1:3,  # Columna ID con valores del 1 al 3
  nombres = c("fernando", "francisco", "javier"),  # Columna con nombres
  edad = c(23, 24, 25)  # Columna con edades
)
# Un data frame permite tener columnas de distintos tipos de datos

# -------------------------------
# Instalación de paquetes (solo una vez por computador)
# -------------------------------

install.packages("readr")      # Paquete para leer datos (CSV, etc.)
install.packages("tidyverse")  # Conjunto de paquetes para manipular y visualizar datos

# -------------------------------
# Cargar paquetes (hacerlo en cada script o sesión nueva)
# -------------------------------

library(readr)      # Carga el paquete 'readr'
library(tidyverse)  # Carga todo el 'tidyverse' (incluye dplyr, ggplot2, etc.)

# -------------------------------
# Lectura de datos desde archivo CSV
# -------------------------------

df_forestal <- read_csv("data/datos_forestales.csv")  # Se carga el archivo CSV a un data frame

# -------------------------------
# Estadísticas descriptivas
# -------------------------------

mean(df_forestal$Altura_m, na.rm = TRUE)     # Calcula la media de la columna 'Altura_m', ignorando NA
median(df_forestal$Altura_m, na.rm = TRUE)   # Calcula la mediana
sd(df_forestal$Altura_m, na.rm = TRUE)       # Calcula la desviación estándar

# -------------------------------
# Exploración rápida del dataset
# -------------------------------

head(df_forestal)     # Muestra las primeras 6 filas del data frame
glimpse(df_forestal)  # Muestra estructura general del data frame (tipo y contenido de cada columna)
summary(df_forestal)  # Muestra resumen estadístico para cada columna

unique(df_forestal$Especie)  # Muestra las especies únicas presentes en el dataset

# -------------------------------
# Visualización: Boxplot de Altura por Especie
# -------------------------------

ggplot(df_forestal, aes(x = Especie, y = Altura_m, fill = Especie)) +
  geom_boxplot()  # Crea un boxplot para comparar la altura entre especies

# -------------------------------
# Filtrar especies de interés
# -------------------------------

df_especies_interes <- df_forestal %>% 
  filter(Especie %in% c("Nothofagus dombeyi", "Nothofagus pumilio"))
# Se filtran solo las filas que pertenecen a esas dos especies

unique(df_especies_interes$Especie)  # Verifica las especies presentes tras el filtrado

# -------------------------------
# Prueba t de Student para comparar alturas entre especies
# -------------------------------

# Hipótesis nula (H0): Las medias son iguales
# H0: μ_Nothofagus_dombeyi = μ_Nothofagus_pumilio

# Hipótesis alternativa (Ha): Las medias son diferentes
# Ha: μ_Nothofagus_dombeyi ≠ μ_Nothofagus_pumilio

prueba_t <- t.test(Altura_m ~ Especie, data = df_especies_interes, var.equal = TRUE)
# Realiza una prueba t para comparar la media de Altura entre las dos especies

print(prueba_t)  # Imprime los resultados de la prueba t

# Estadístico t: 1.04
# Grados de libertad: 446
# Valor p: 0.29 (mayor a 0.05)
# Interpretación: No hay evidencia suficiente para afirmar que las alturas medias son diferentes
# Por lo tanto, NO se rechaza la hipótesis nula
