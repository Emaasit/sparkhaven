sparkhaven: Read SAS, SPSS, & STATA data files into Spark DataFrames
====================================================================

What is sparkhaven?
-------------------

sparkhaven is an extension for sparklyr to read SAS, SPSS, & STATA data
files into Spark DataFrames. It uses different Spark packages to load
such datasets in parallel in Spark.

**Currently, there's functionality for SAS only. SPSS & STATA will come
shortly. Submit a pull request if interested in contributing**.

Installation
------------

sparkhaven requires the sparklyr package to run

### Install sparklyr

I recommend the latest stable version of sparklyr available on CRAN

    install.packages("sparklyr")

### Install sparkhaven

Install the development version of sparkhaven from this Github repo
using devtools

    library(devtools)
    devtools::install_github("emaasit/sparkhaven")

Connecting to Spark
-------------------

If Spark is not already installed, use the following sparklyr command to
install your prefered version of Spark:

    library(sparklyr)
    spark_install(version = "2.0.0")

The call to will make the sparkhaven functions available on the R search
path and will also ensure that the dependencies required by the package
are included when we connect to Spark.

    library(sparkhaven) 

We can create a Spark connection as follows:

    sc <- spark_connect(master = "local")

Reading SAS files
-----------------

sparkhaven provides the function `spark_read_sas` to read SAS data files
in .sas7bdat format into Spark DataFrames. It uses a Spark package
called spark-sas7bdat. Here's an example.

In the example below, we read a sas data file called mtcars.sas7bdat
into a table called sas\_table in Spark.

    mtcars_file <- system.file("extdata", "mtcars.sas7bdat", package = "sparkhaven")

    mtcars_df <- spark_read_sas(sc, path = mtcars_file, table = "sas_example")
    mtcars_df

The resulting pointer to a Spark table can be further used in dplyr
statements.

    library(dplyr)
    mtcars_df %>% group_by(cyl) %>%
      summarise(count = n(), avg.mpg = mean(mpg), avg.displacment = mean(disp), avg.horsepower = mean(hp))

Reading SPSS files
------------------

**Coming soon!**

Reading STATA files
-------------------

**Coming soon!**

Logs & Disconnect
-----------------

Look at the Spark log from R:

    spark_log(sc, n = 100)

Now we disconnect from Spark:

    spark_disconnect(sc)
