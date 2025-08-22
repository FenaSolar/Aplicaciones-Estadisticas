# AYUDANTÍA 02 - ANOVA, pruebas post-hoc y visualización con boxplot

# -------------------------------
# Instalación de paquetes (solo una vez por computador)
# -------------------------------

install.packages("openxlsx")  # Paquete para leer y escribir archivos Excel
install.packages("ggplot2")   # Paquete para hacer gráficos

# -------------------------------
# Cargar paquetes (hacerlo en cada script o sesión nueva)
# -------------------------------

library(openxlsx)  # Carga el paquete 'openxlsx'
library(ggplot2)   # Carga el paquete 'ggplot2'

# -------------------------------
# Lectura de datos desde archivo Excel
# -------------------------------

datos_cobertura <- read.xlsx("data/02_datos_cobertura_vegetal.xlsx")
# Se lee el archivo Excel y se guarda en el objeto 'datos_cobertura'
# Este dataset debe tener al menos dos columnas: 
#   - 'valor' (numérica)
#   - 'grupo' (categórica, con varios niveles)

# -------------------------------
# Exploración rápida del dataset
# -------------------------------

summary(datos_cobertura)  # Resumen estadístico de cada variable
head(datos_cobertura)     # Primeras 6 filas del dataset

# -------------------------------
# ANOVA (Análisis de Varianza)
# -------------------------------

# Objetivo: comparar si el promedio de 'valor' es distinto entre los diferentes 'grupo'
# Hipótesis nula (H0): Las medias de todos los grupos son iguales
# Hipótesis alternativa (Ha): Al menos un grupo tiene una media diferente

modelo_anova <- aov(valor ~ grupo, data = datos_cobertura)  
# Ajusta un modelo ANOVA donde 'valor' depende del factor 'grupo'

modelo_anova            # Muestra información básica del modelo
summary(modelo_anova)   # Tabla ANOVA con valores de F y p-value

# -------------------------------
# Prueba post-hoc de Tukey
# -------------------------------

# Si el ANOVA es significativo (p < 0.05), usamos Tukey para ver 
# entre qué pares de grupos están las diferencias

tukey <- TukeyHSD(modelo_anova)
tukey  # Resultados del test de comparaciones múltiples

# -------------------------------
# Visualización: Boxplot por grupo
# -------------------------------

# Un boxplot permite comparar la distribución de los valores dentro de cada grupo
# La caja muestra la mediana, los cuartiles y los valores atípicos

ggplot(datos_cobertura, aes(x = grupo, y = valor)) +
  geom_boxplot(fill = "lightblue") +  # color azul claro para las cajas
  theme_minimal()                     # estilo limpio del gráfico

# Otra versión sin relleno
ggplot(datos_cobertura, aes(x = grupo, y = valor)) +
  geom_boxplot()
  geom_boxplot()