##################################################################
# Análisis de varianza (ANOVA) en R con visualización gráfica
# Este script está pensado para alumnos que recién comienzan con R
##################################################################

# ---- 1. Instalar paquetes ----
# Los paquetes son "extensiones" que nos dan funciones extra.
# Solo se instalan una vez. Si ya los tienes instalados, no necesitas correr estas líneas.
install.packages("openxlsx")  # Permite leer y escribir archivos Excel
install.packages("ggplot2")   # Permite hacer gráficos de calidad

# ---- 2. Cargar paquetes ----
# Cada vez que abras R y quieras usar un paquete, tienes que cargarlo con library().
library(openxlsx)  
library(ggplot2)   

# ---- 3. Importar datos ----
# Aquí leemos un archivo Excel (.xlsx) que contiene nuestros datos.
# Cambia la ruta si tu archivo está en otra carpeta.
datos_cobertura <- read.xlsx("data/02_datos_cobertura_vegetal.xlsx")

# ---- 4. Explorar los datos ----
# 'summary()' nos da un resumen estadístico de cada variable (mínimo, máximo, mediana, etc.)
summary(datos_cobertura)

# 'head()' nos muestra las primeras 6 filas del dataset, útil para revisar cómo vienen los datos.
head(datos_cobertura)

# ---- 5. Ajustar un modelo ANOVA ----
# ANOVA (Análisis de Varianza) se usa para comparar si hay diferencias 
# significativas entre los promedios de varios grupos.
# En este ejemplo, "valor" es la variable numérica y "grupo" es la categórica.
modelo_anova <- aov(valor ~ grupo, data = datos_cobertura)

# Mostramos el resultado del modelo
modelo_anova

# 'summary()' del modelo nos da la tabla ANOVA con valores de F y p-value
summary(modelo_anova)

# ---- 6. Prueba post-hoc (Tukey) ----
# Si el ANOVA muestra diferencias significativas, TukeyHSD nos ayuda a ver 
# entre qué grupos están esas diferencias.
tukey <- TukeyHSD(modelo_anova)
tukey

# ---- 7. Visualización de resultados ----
# Un boxplot nos permite ver la distribución de los datos dentro de cada grupo.
# Cada caja representa la mediana, cuartiles y posibles valores atípicos.
ggplot(datos_cobertura, aes(x = grupo, y = valor)) +
  geom_boxplot(fill = "lightblue") + # color de relleno azul claro
  theme_minimal()                    # estilo de gráfico limpio

# También podemos hacerlo sin color de relleno, para ver la versión básica
ggplot(datos_cobertura, aes(x = grupo, y = valor)) +
  geom_boxplot()