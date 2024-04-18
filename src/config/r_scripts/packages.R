# Packages used in the across both Processing and Geospatial scripts.

devtools::install_github("dmurdoch/leaflet@crosstalk4")

packages <- c("here",
              "purrr",
              "tidyverse",
              "tidyr",
              "stringr",
              "openxlsx",
              "sf",
              "plotly",
              "readxl",
              "htmltools",
              "shiny",
              "readxl",
              "dplyr", 
              "crosstalk",
              "leaflet")

lapply(packages, library, character.only=TRUE)