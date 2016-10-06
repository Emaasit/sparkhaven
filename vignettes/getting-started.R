## ----eval = FALSE--------------------------------------------------------
#  install.packages("sparklyr")

## ----eval = FALSE--------------------------------------------------------
#  library(devtools)
#  devtools::install_github("emaasit/sparkhaven")

## ----eval = FALSE--------------------------------------------------------
#  library(sparklyr)
#  spark_install(version = "2.0.0")

## ----eval = FALSE--------------------------------------------------------
#  library(sparkhaven)

## ----eval = FALSE--------------------------------------------------------
#  sc <- spark_connect(master = "local")

## ----eval = FALSE--------------------------------------------------------
#  mtcars_file <- system.file("extdata", "mtcars.sas7bdat", package = "sparkhaven")
#  
#  mtcars_df <- spark_read_sas(sc, path = mtcars_file, table = "sas_example")
#  mtcars_df

## ----eval = FALSE--------------------------------------------------------
#  library(dplyr)
#  mtcars_df %>% group_by(cyl) %>%
#    summarise(count = n(), avg.mpg = mean(mpg), avg.displacment = mean(disp), avg.horsepower = mean(hp))

## ----eval = FALSE--------------------------------------------------------
#  spark_log(sc, n = 100)

## ----eval = FALSE--------------------------------------------------------
#  spark_disconnect(sc)

