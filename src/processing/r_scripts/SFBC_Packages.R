# Packages used in the AIDF Short Form Business Case (SFBC) ETL pipeline.


packages <- c("readxl",
              "purrr",
              "tidyverse",
              "tidyr",
              "here",
              "stringr")

lapply(packages, library, character.only=TRUE)