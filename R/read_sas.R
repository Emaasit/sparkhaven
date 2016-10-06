
spark_remove_table_if_exists <- function(sc, name) {
  if (name %in% src_tbls(sc)) {
    dbRemoveTable(sc, name)
  }
}

spark_read_sas <- function(sc,
                           name,
                           path,
                           overwrite = TRUE){
  if(missing(sc)){
    stop("Error! Please provide the spark connection")
  }
  if(missing(path)){
    stop("Error! Please provide the path")
  }
  if(missing(name)){
    stop("Error! Please provide the name of the Spark table where to store the SAS file into")
  }
  if (overwrite) spark_remove_table_if_exists(sc, name)

  x <- hive_context(sc) %>%
    invoke("read") %>%
    invoke("format", "com.github.saurfang.sas.spark") %>%
    invoke("load", path)

  sdf <- sdf_register(x, name = name)
  sdf
}

spark_dependencies <- function(spark_version, scala_version, ...) {
  spark_dependency(
    packages = c(
      sprintf("saurfang:spark-sas7bdat:1.1.4-s_%s", scala_version)
    )
  )
}
.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}
